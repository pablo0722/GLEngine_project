#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "GLEngine/GLEngine.hpp"

void update(void *ctx, float deltatime) {
    printf("%s: deltatime: %d s %d ms %d ns\n", __func__, (int) deltatime, (int) (deltatime * 1000) % 1000, (int) (deltatime * 1000 *1000) % (1000));
}

int main() {
    GLEngine engine;

    engine.create("EGL Example", 1500, 100, 1024, 768);

    engine.registerUpdateFunc(update);

    engine.loop();

    return 0;
}
