#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "WindowSystem/EglWindowSystem.hpp"

// typedef struct
// {
//    // Handle to a program object
//    GLuint programObject;

// } UserData;

int main_WinSystem_CreateExample() {
    WinSystem ws;

    ws.create("EGL Example", 1500, 100, 1024, 768);

    while(WinSystem::Event::Delete != ws.getEvent())
    {
        // If no sleep, 100% of one core will consumed. Overall system will continuing working normally using other cores.
        usleep(10000);
    }

    return 0;
}

int main() {
    Engine engine;

    engine.create();

    return 0;
}

// int eglCreate(Khronos_Context *context) {
//     printf("%s: %s\n", __func__, "Starting EGL example...");

//     context->userData = malloc(sizeof(UserData));

//     context->windowTitle = "Hello Triangle";
//     context->width = 320;
//     context->height = 240;
//     context->windowFlags = ES_WINDOW_RGB;

//     printf("%s: %s\n", __func__, "End");

//     return GL_TRUE;
// }

// int eglStart(Khronos_Context *context) {

//     // if ( !Init ( context ) )
//     // {
//     //     return GL_FALSE;
//     // }

//     // esRegisterShutdownFunc(context, Shutdown);
//     // esRegisterDrawFunc(context, Draw);

//     return GL_TRUE;
// }

// int eglStop(Khronos_Context *context) {

//     return GL_TRUE;
// }

// int eglDestroy(Khronos_Context *context) {
// }