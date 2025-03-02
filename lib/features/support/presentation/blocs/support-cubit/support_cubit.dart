import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/support/data/support_repo_implement.dart';
import 'package:trading/features/support/domain/models/support_message_model.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  List<SupportMessageModel> messageList = [];
  int lastMessageIdDb = 0;
  int currentUserId = 0;
  int periodicCycleCount = 0;
  String currentUserName = "";
  SupportRepo supportRepo;
  SupportCubit({required this.supportRepo}) : super(SupportInitial());

  Future getSupportMessages() async {
    const t = "getSupportMessage- SupportCubit";
    periodicCycleCount++;
    if (!isClosed) {
      emit(SupportLoadingState());
    }
    await getCurrentUserIdAndName();
    final response = await supportRepo.getSupportMessage(userId: currentUserId);
    response.fold(
      (errorModel) {
        emit(SupportFailureState(message: errorModel.errorMessageEn ?? "Unkown Error Occured"));
      },
      (messages) {
        // messageList.length.prm("$t >> messageList length");
        // messages.last.id.prm("$t >> last message fetched from db id");
        if (messageList.isNotEmpty && messages.last.id == lastMessageIdDb && periodicCycleCount < 10) {
          // no new messages in the database
          "No new messages in the database".prm(t);
        } else {
          if (messages.isEmpty || messages == []) {
            "The database is empty for current user id =  $currentUserId".prm(t);
            messageList = [];
            return;
          }
          // "new messages found in the database".prm(t);
          messageList = [];
          periodicCycleCount = 0;
          messageList = messages;
          lastMessageIdDb = messages.last.id!;
          if (!isClosed) {
            emit(SupportAddNewState());
          }
        }
      },
    );
  }

  Future<int> getCurrentUserIdAndName() async {
    final userModel = await sl<AuthRepo>().getChacedUserData();
    currentUserId = (userModel?.id) ?? 0;
    currentUserName = (userModel?.userName) ?? "";
    return currentUserId;
  }

  Future postNewChatMessage({required int userId, required String message}) async {
    final response = await supportRepo.postNewSupportMessage(userId: userId, message: message);
    response.fold(
      (errorModel) {
        emit(SupportFailureState(message: errorModel.errorMessageEn ?? "Unkown Error Occured"));
      },
      (_) async {
        // await periodicCheck();
      },
    );
  }

  Future periodicCheck() async {
    await getSupportMessages();
  }
}
