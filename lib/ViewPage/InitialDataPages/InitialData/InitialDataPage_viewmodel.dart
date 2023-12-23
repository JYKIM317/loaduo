import 'package:loaduo/ViewPage/InitialDataPages/InitialData/InitialDataPage_model.dart';

class InitialDataViewModel {
  Future<void> concernlogic({
    required bool raid,
    required bool adventure,
    required bool homework,
  }) async {
    Map<String, List<dynamic>> myConcern = {};
    List<String> concernList = [];
    raid ? concernList.add('레이드') : null;
    adventure ? concernList.add('내실') : null;
    homework ? concernList.add('일일숙제') : null;
    myConcern.addAll({'concern': concernList});
    await InitialDataModel().updateMyInfo(data: myConcern);
  }

  Future<void> raidstyle({
    required int mood,
    required int distribute,
    required int skill,
  }) async {
    Map<String, String> mystyle = {};
    switch (mood) {
      case 0:
        mystyle.addAll({'raidMood': '예민하지 않아요'});
        break;
      case 1:
        mystyle.addAll({'raidMood': '예민해요'});
        break;
      default:
        mystyle.addAll({'raidMood': '예민하지 않아요'});
        break;
    }
    switch (distribute) {
      case 0:
        mystyle.addAll({'raidDistribute': '천천히 빼요'});
        break;
      case 1:
        mystyle.addAll({'raidDistribute': '몰아서 빼요'});
        break;
      default:
        mystyle.addAll({'raidDistribute': '천천히 빼요'});
        break;
    }
    switch (skill) {
      case 0:
        mystyle.addAll({'raidSkill': '숙련'});
        break;
      case 1:
        mystyle.addAll({'raidSkill': '반숙'});
        break;
      case 2:
        mystyle.addAll({'raidSkill': '클경'});
        break;
      case 3:
        mystyle.addAll({'raidSkill': '트라이'});
        break;
      default:
        mystyle.addAll({'raidSkill': '숙련'});
        break;
    }
    await InitialDataModel().updateMyInfo(data: mystyle);
  }

  Future<void> playtime({
    required int weekday,
    required int weekend,
  }) async {
    Map<String, int> myPlaytime = {};

    myPlaytime.addAll({
      'weekdayPlaytime': weekday,
      'weekendPlaytime': weekend,
    });
    await InitialDataModel().updateMyInfo(data: myPlaytime).then((_) async {
      await InitialDataModel().updateInitialDataExist();
    });
  }
}
