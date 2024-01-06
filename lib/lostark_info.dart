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
    '발탄': ['[노말]', '[하드]', '[헬]'],
    '비아키스': ['[노말]', '[하드]', '[헬]'],
    '쿠크세이튼': ['[노말]', '[하드]', '[헬]'],
    '아브렐슈드': ['[노말]', '[하드]', '[헬]'],
    '일리아칸': ['[노말]', '[하드]'],
    '카멘': ['[노말]', '[하드]', '[더 퍼스트]'],
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

  Map<String, String> networkImage = {
    '발탄':
        'https://i.namu.wiki/i/2K3H6jdfhd6EdBP0Is9QOancMyWW70xwo6wGl20LbvZSUn4dW6UnsLyb9_BUX9R5UiRxsW2lC5RVnVMZR0Pd79T-3Or0AvzBgeLt_tSuk3zZ65vPTJ4Zjkh7r7P06iNoDT9_UO9PqXx2n8wgs9DFpQ.webp',
    '비아키스':
        'https://i.namu.wiki/i/Ez62q4h-IC9K3fC-CBcxhzCgBFpZFl4nmCrP18PpbW2SO5-p1yrsFzcRjBK8g08_TOj4Zg90rw4IORprW6G6q04lk5KtEV5CcwzbdeADbMWyhAvtLbD4y45D8rqwF_ylGZxnP50cqVaFIwDRnsDiVQ.webp',
    '쿠크세이튼':
        'https://i.namu.wiki/i/npbCwOJxJlH4wUmODKoOyWh1JiLCLWcFZdE2nhhXzmNa4BHTxYPyI2RMwomCmBAm9DVEs2StsLexaR6S-Lhth7Z-rxLQpz_jHe5VdmgLX6MlOxXiJJn78ufD5CqUAxkv_Z1vYB3sWx0ORNP4YLcrxA.webp',
    '아브렐슈드':
        'https://i.namu.wiki/i/6EDopCodDiCMBZeMxUtb5OkgWu6ZNG7wYW_cyWYrHoBRoe_G_L-0qbaTaw4XAROLwrTQ0aFGUHZA13j78u0fRdEG7JAorg5O5x94wJ2YOdxukgfqWyfT2uYUeDe6KVQjPpFObD-Z_L8e-05o7JCYOA.webp',
    '일리아칸':
        'https://i.namu.wiki/i/Eeit-rQASZa1pVlNUMI13d7sQZ2glGuTC3SMoUEbGGxWZDFzo9skzOVSyyzCDppizjkl4gPch7v11ZaxzgwiPkW_vE-hn3hF6Sk-5KGk8EhOGR_2u077Fq1z-B71I4zLl5D2znptGl2VUwiGFMgrZA.webp',
    '카멘':
        'https://i.namu.wiki/i/Z1cjBj0GaTZ6m85N_KndtaC4IGEn2qqsUKHwwrkvC6sHvJpgcM-2Uz9vfZXQACp6Omz83pDamQuVWmq4UByTFIxwbUGLqWAZyZhspvbVluvkwg0mC3_RZtZXJMtACLrqyw5ei1zQCptfCGe-0GDfDA.webp',
    '카양겔':
        'https://upload3.inven.co.kr/upload/2022/04/27/bbs/i13821724088.jpg?MW=800',
    '혼돈의 상아탑':
        'https://upload3.inven.co.kr/upload/2023/09/17/bbs/i17203791047.jpg?MW=800',
    '에키드나':
        'https://ac-p2.namu.la/20231217sac/9acc15aa89b19ae8be8cf2d5674c430fa82ba7f5e03346f86c1eadf73a36e7a2.webp?expires=1704394648&key=eRHyCg3FzeFWbt73RPHstA',
    '깐부':
        'https://cdn-lostark.game.onstove.com/2021/event/210331_event/images/emoticon/emoticon_1.png',
    '길드':
        'https://cdn-lostark.game.onstove.com/2021/event/210331_event/images/emoticon/emoticon_9.png',
  };
}
