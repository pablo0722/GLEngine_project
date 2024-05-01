#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "GLEngine/GLEngine.hpp"

int main() {
    GLEngine engine;

    engine.create("EGL Example", 1500, 100, 1024, 768);

    engine.loop();

    return 0;
}
