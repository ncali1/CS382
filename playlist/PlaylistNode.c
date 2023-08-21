#include <stdio.h>
#include <string.h>
#include "PlaylistNode.h"

void SetPlaylistNode(PlaylistNode* thisnode, char idInit[], char songNameInit[], char artistNameInit[], int songLengthInit){
    strcpy(thisnode->uniqueID, idInit);
    strcpy(thisnode->songName, songNameInit);
    strcpy(thisnode->artistName, artistNameInit);
    thisnode->songLength = songLengthInit;   
}

void PrintPlaylistNode(PlaylistNode* thisnode){
    printf("Unique ID: %s\n", thisnode->uniqueID);
    printf("Song Name: %s\n", thisnode->songName);
    printf("Artist Name: %s\n", thisnode->artistName);
    printf("Song Length (in seconds) %d", thisnode->songLength);
}


PlaylistNode* GetNextPlaylistNode(PlaylistNode* thisnode){
    return thisnode->nextNodePtr;
}