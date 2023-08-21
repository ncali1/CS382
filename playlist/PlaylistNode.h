#include <stdio.h>
#include <string.h>


#ifndef PLAYLIST_NODE
#define PLAYLIST_NODE

typedef struct PlaylistNode{
    char uniqueID[50];
    char songName[50];
    char artistName[50];
    int songLength;
    struct PlaylistNode* nextNodePtr;
} PlaylistNode;

void SetPlaylistNode(PlaylistNode* thisnode, char idInit[], char songNameInit[], char artistNameInit[], int songLengthInit);

void PrintPlaylistNode(PlaylistNode* thisnode);

PlaylistNode* GetNextPlaylistNode(PlaylistNode* thisnode);



#endif