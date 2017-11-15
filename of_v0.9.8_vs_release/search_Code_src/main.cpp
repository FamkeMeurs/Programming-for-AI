#include "ofMain.h"
#include "ofApp.h"

#include "constants.h"

//========================================================================
int main() {
    std::cout << "SearchStrategies v" << APP_VERSION_MAJOR << '.' << APP_VERSION_MINOR << '\n';
    
	ofSetupOpenGL(WINDOW_WIDTH, WINDOW_HEIGHT, OF_WINDOW);
	ofRunApp(new ofApp());
}
