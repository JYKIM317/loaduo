import 'package:flutter/material.dart';
import 'CustomIcon.dart';

class lostarkInfo {
  List<String> serverList = [
    '전체',
    '루페온',
    '실리안',
    '아만',
    '카마인',
    '카제로스',
    '아브렐슈드',
    '카단',
    '니나브',
  ];

  List<String> raidType = ['전체', '군단장 레이드', '어비스 던전', '카제로스 레이드'];

  List<String> legionRaidList = ['발탄', '비아키스', '쿠크세이튼', '아브렐슈드', '일리아칸', '카멘'];

  List<String> abyssDungeonList = ['카양겔', '혼돈의 상아탑'];

  List<String> kazerosRaidList = ['에키드나'];

  Map<String, dynamic> raidDifficulty = {
    '발탄': ['[노말]', '[하드]'],
    '비아키스': ['[노말]', '[하드]'],
    '쿠크세이튼': ['[노말]'],
    '아브렐슈드': ['[노말]', '[하드]'],
    '일리아칸': ['[노말]', '[하드]'],
    '카멘': ['[노말]', '[하드]'],
    '카양겔': ['[노말]', '[하드]'],
    '혼돈의 상아탑': ['[노말]', '[하드]'],
    '에키드나': ['[노말]', '[하드]'],
  };

  Map<String, dynamic> raidMaxPlayer = {
    '발탄': 8,
    '비아키스': 8,
    '쿠크세이튼': 4,
    '아브렐슈드': 8,
    '일리아칸': 8,
    '카멘': 8,
    '카양겔': 4,
    '혼돈의 상아탑': 4,
    '에키드나': 8,
  };

  Map<String, dynamic> raidLevel = {
    '발탄 [노말]': 1415,
    '발탄 [하드]': 1445,
    '비아키스 [노말]': 1430,
    '비아키스 [하드]': 1460,
    '쿠크세이튼 [노말]': 1475,
    '아브렐슈드 [노말]': 1490,
    '아브렐슈드 [하드]': 1540,
    '일리아칸 [노말]': 1580,
    '일리아칸 [하드]': 1600,
    '카멘 [노말]': 1610,
    '카멘 [하드]': 1630,
    '카양겔 [노말]': 1540,
    '카양겔 [하드]': 1580,
    '혼돈의 상아탑 [노말]': 1600,
    '혼돈의 상아탑 [하드]': 1620,
    '에키드나 [노말]': 1620,
    '에키드나 [하드]': 1630,
  };

  Map<String, String> networkImage = {
    '발탄':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/valtan.jpg?alt=media&token=4e1164be-88f1-4329-b085-3e91ce46127f',
    '비아키스':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/vyakis.jpg?alt=media&token=e74ce304-3ff9-4fd0-b86f-f5958f5299c9',
    '쿠크세이튼':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/kukasaden.jpg?alt=media&token=79adf2e1-d91e-4ff3-ad12-c9877f56ab24',
    '아브렐슈드':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/abrelshud.jpg?alt=media&token=d46d61f4-ee1d-46f2-b2d2-00ce38001830',
    '일리아칸':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/illiakan.jpeg?alt=media&token=cf409f2d-8895-4dc5-a090-843bcf8f4845',
    '카멘':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/kamen.jpg?alt=media&token=c78fc254-b7cf-48b2-887f-5f855eee6a62',
    '카양겔':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/kayangel.jpeg?alt=media&token=57c714b0-03d6-471c-9341-491dec70f816',
    '혼돈의 상아탑':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/sangatower.jpeg?alt=media&token=89f875cf-6707-4320-b077-0d2d95b284e0',
    '에키드나':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/ekidna.jpg?alt=media&token=ed549f2e-996a-44f1-ae3b-74bac4a8f2a0',
    '깐부':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/gganbu.png?alt=media&token=b9d6cbf3-f36f-49c8-b22a-b876d45b6a23',
    '길드':
        'https://firebasestorage.googleapis.com/v0/b/loaduo.appspot.com/o/guild.png?alt=media&token=3f096f50-d5ad-43c1-82d4-8cd8d82a451b',
  };

  int maxLevel = 1675;

  Map<String, IconData> classIcon = {
    //전사
    '버서커': CustomIcon.berserker,
    '디스트로이어': CustomIcon.destroyer,
    '워로드': CustomIcon.gunlancer,
    '홀리나이트': CustomIcon.paladin,
    '슬레이어': CustomIcon.slayer,
    //무도가
    '배틀마스터': CustomIcon.wardancer,
    '인파이터': CustomIcon.scrapper,
    '기공사': CustomIcon.soulfist,
    '창술사': CustomIcon.glaivier,
    '스트라이커': CustomIcon.striker,
    '브레이커': CustomIcon.breaker,
    //헌터
    '데빌헌터': CustomIcon.deadeye,
    '블래스터': CustomIcon.artillerist,
    '호크아이': CustomIcon.sharpshooter,
    '스카우터': CustomIcon.machinist,
    '건슬링어': CustomIcon.gunslinger,
    //마법사
    '바드': CustomIcon.bard,
    '서머너': CustomIcon.summoner,
    '아르카나': CustomIcon.arcanist,
    '소서리스': CustomIcon.sorceress,
    //암살자
    '블레이드': CustomIcon.deathblade,
    '데모닉': CustomIcon.shadowhunter,
    '리퍼': CustomIcon.reaper,
    '소울이터': CustomIcon.souleater,
    //스페셜리스트
    '도화가': CustomIcon.artist,
    '기상술사': CustomIcon.aeromancer,
  };
}
