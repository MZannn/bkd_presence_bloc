String initialName(String userName) {
  return userName.trim().split(' ').map((l) => l[0]).take(2).join();
}
