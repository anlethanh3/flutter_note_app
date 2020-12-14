class Locale {
  String appname,
      complete,
      incomplete,
      all,
      addNote,
      todoName,
      todoNameRequired,
      confirm,
      yes,
      no,
      delete,
      save;

  void load(String locale) {
    final texts = getTexts()[locale];
    appname = texts['appname'] ?? '';
    complete = texts['complete'] ?? '';
    all = texts['all'] ?? '';
    incomplete = texts['incomplete'] ?? '';
    addNote = texts['addNote'] ?? '';
    todoName = texts['todoName'] ?? '';
    todoNameRequired = texts['todoNameRequired'] ?? '';
    confirm = texts['confirm'] ?? '';
    yes = texts['yes'] ?? '';
    no = texts['no'] ?? '';
    delete = texts['delete'] ?? '';
    save = texts['save'] ?? '';
  }

  Map<String, Map<String, String>> getTexts() => {
        'vn': {
          'appname': 'Ghi chú',
          'complete': 'Hoàn thành',
          'all': 'Tất cả',
          'incomplete': 'Chưa làm',
          'addNote': 'Thêm việc',
          'todoName': 'Nhập tên việc cần làm',
          'todoNameRequired': 'Hãy nhập tên việc cần làm',
          'confirm': 'Xác nhận xoá việc này?',
          'yes': 'Đồng ý',
          'no': 'Huỷ',
          'delete': 'Xoá',
          'save': 'Lưu',
        },
        'us': {
          'appname': 'Note app',
          'complete': 'Complete',
          'all': 'All',
          'incomplete': 'InComplete',
          'addNote': 'Add todo',
          'todoName': 'Input ToDo Name',
          'todoNameRequired': 'ToDo name is required',
          'confirm': 'Confirm delete this note?',
          'yes': 'OK',
          'no': 'Cancel',
          'delete': 'Delete',
          'save': 'Save',
        }
      };
}
