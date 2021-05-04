#include <sys/time.h>
#include <iostream>
#include <unistd.h>

uint64_t GetCurrentMS() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec * 1000ul + tv.tv_usec / 1000;
}

class Timer {
 public:
    Timer() : m_state (STOP)
            , m_current (0)
            , m_pause_time (0) {
    }
    void start() {
        std::cout << "start" << std::endl;
        if (m_state == START) {
            return;
        }
        m_state = START;
        m_pause_time = GetCurrentMS();
    }
    void pause() {
        std::cout << "pause" << std::endl;
        if (m_state == STOP || m_state == PAUSE) {
            return;
        }
        m_state = PAUSE;
        m_current += GetCurrentMS() - m_pause_time;
    }
    void stop() {
        std::cout << "stop" << std::endl;
        if (m_state == STOP) {
            return;
        }
        m_state = STOP;
        m_current = 0;
    }
    uint64_t read() {
        if (m_state == START) {
            return m_current + GetCurrentMS() - m_pause_time;
        } else {
            return m_current;
        }
    }
    void printTime() {
        std::cout << read() << std::endl;
    }
 private:
    enum State {
        START = 0,
        PAUSE = 1,
        STOP = 2
    };
    State m_state;     
    uint64_t m_current = 0;
    uint64_t m_pause_time = 0;
};


int main() {
    Timer t;
    t.start();
    sleep(1);
    t.printTime();
    sleep(1);
    t.pause();
    t.printTime();
    sleep(1);
    t.start();
    t.printTime();
    sleep(1);
    t.printTime();
    t.stop();
    t.printTime();
    sleep(1);
    t.start();
    t.printTime();
    sleep(3);
    t.pause();
    t.printTime();
    return 0;
}
