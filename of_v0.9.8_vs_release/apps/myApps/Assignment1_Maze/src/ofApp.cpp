#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofBackground(255, 255, 255);
    
    // init random generator
    std::srand((unsigned int)std::time(0));
    
    grid.generateMaze();
}

//--------------------------------------------------------------
void ofApp::update() {

}

//--------------------------------------------------------------
void ofApp::draw() {
    grid.draw();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key) {
    switch(key) {
        case 'm':
            grid.reset();
            grid.generateMaze();
            break;
        case 'r':
            grid.reset();
            grid.generateRooms();
            break;
        case 'o':
            grid.reset();
            grid.generateObstacles();
            break;
        case 'j':
            grid.reset();
            grid.generateJail();
            break;
        case 'd':
            grid.depthFirstSearch();
            break;
        case 'b':
            grid.breadthFirstSearch();
            break;
        case 'g':
            grid.greedySearch();
            break;
        case 'a':
            grid.aStarSearch();
            break;
        case 'q':
            ofExit();
    }
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button) {

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button) {

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y) {
    
}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y) {
    
}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h) {

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg) {

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo) {

}
