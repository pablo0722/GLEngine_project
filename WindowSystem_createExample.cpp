#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "WindowSystem/WindowSystemLinux.hpp"
#include "WindowSystem/WindowEvent.hpp"

int main() {
    WindowSystemLinux ws;

    ws.attachToNativeDisplay();
    ws.createNativeWindow("EGL Example", 0, 0, 1024, 768);

    WindowEvent event;

    bool done = false;
    while(!done)
    {
        ws.getEvent(&event);
        while(WindowEvent::Type::NoEvent != event.type) {
            switch (event.type) {
                case WindowEvent::Type::DeleteEvent: {
                    done = true;
                } break;

                default: {
                } break;
            }

            if(done) {
                break;
            }

            ws.getEvent(&event);
        }

        if(done) {
            break;
        }

        // If no sleep, 100% of one core will consumed. Overall system will continuing working normally using other cores.
        // Note: printf is blocking call, so current core will be relaxed during the print duration (about 7ns +- 5ns).
        //usleep(10000);
    }

    return 0;
}