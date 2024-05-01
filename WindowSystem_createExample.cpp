#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "WindowSystem/WindowSystem.hpp"

int main() {
    WindowSystem ws;

    ws.create("EGL Example", 1500, 100, 1024, 768);

    while(WindowSystem::Event::Delete != ws.getEvents())
    {
        // If no sleep, 100% of one core will consumed. Overall system will continuing working normally using other cores.
        // Note: printf is blocking call, so current core will be relaxed during the print duration (about 7ns +- 5ns).
        usleep(10000);
    }

    return 0;
}