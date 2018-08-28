class Timer {
  int startTime; // when the timer started
  int timeLength; // length of timer
  int offset; // pause the timer

  Timer(int len) {
    timeLength = len;
    offset = 0;
  }

  void pause() { 
    offset = elapsed();
  } // TODO: really flesh this out and make it more than a hack

  void begin() { 
    startTime = millis() / 1000; 
    offset = 0;
    println("start time  " + startTime);
    println("elapsed:  " + elapsed());
  }

  int elapsed() {
    if (offset > 0) 
      return offset;
    return millis() / 1000 - startTime;
  }

  boolean timeup() { 
    return elapsed() > timeLength;
  }
}

