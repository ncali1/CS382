#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "PlaylistNode.h"


void PrintMenu(char playlistTitle[]) {   
	printf("%s PLAYLIST MENU\n", playlistTitle);   
	printf("a - Add song\n");   
	printf("r - Remove song\n");   
	printf("o - Output full playlist\n");   
	printf("q - Quit\n\n");
}


PlaylistNode* ExecuteMenu(char option, char playlistTitle[], PlaylistNode* headNode) {   
	char uniqueID[50];    	
	char songName[50];
	char artistName[50];
    int songLength;
	PlaylistNode* tail = NULL;
	PlaylistNode* newNode = (PlaylistNode*)malloc(sizeof(PlaylistNode));
	PlaylistNode* currentNode = headNode;		
	PlaylistNode* previousNode;

	
	switch (option) {      
		case 'a':         
			/* Add a song */  		

			printf("ADD SONG\n");
			getchar();

			printf("Enter song's unique ID:\n");
			fgets(uniqueID, 50, stdin);
			//uniqueID[strlen(uniqueID) - 1] = '\0';

			printf("Enter song's name:\n");
			fgets(songName, 50, stdin);
			//songName[strlen(songName) - 1] = '\0';

			printf("Enter artist's name:\n");
			fgets(artistName, 50, stdin);
			//artistName[strlen(artistName) - 1] = '\0';

			printf("Enter song's length (in seconds):");
			scanf("%d" , &songLength);  
			printf("\n\n");
		
			if (headNode == NULL){
				headNode = newNode;
				//tail = newNode;
			}else{
				tail->nextNodePtr = newNode;

			}
			return headNode;
			break;      

		case 'r':         
			/* Remove a song */         
			printf("REMOVE SONG\n");
			printf("Enter song's unique ID: \n");
			fgets(uniqueID, 50, stdin);
			fgets(songName, 50, stdin);

			printf("\"%s removed\"");

			if (strcmp(GetNextPLaylistNode(headNode), NULL)){
				headNode->nextNodePtr = currentNode;
				headNode = previousNode;
			}else{
				while (currentNode != NULL && currentNode->nextNodePtr != NULL){
					if (currentNode->uniqueID == uniqueID){
						previousNode->nextNodePtr = currentNode->nextNodePtr;
						free(currentNode);
					}else{
						previousNode = currentNode;
						currentNode = currentNode->nextNodePtr;
					}
				}
			}




			break;      
		case 'o':     
			/* Print all songs in the list */   
			getchar();
			printf("%s - OUTPUT FULL PLAYLIST\n", playlistTitle);      
			if (headNode == NULL){
				printf("Playlist is empty\n\n");
			}else{
				int track = 1;
				while (currentNode != NULL){
					printf("%d.\n", track);
					PrintPlaylistNode(currentNode);
					track++;
					currentNode = currentNode->nextNodePtr;
				}
			}
			break;   
	}
	return headNode;
}



int main(void) {   
	// Prompt user for playlist title   
	char menuOp = ' ';
	PlaylistNode* headNode = NULL;
	char playlistTitle[50] = "";
	printf("Enter playlist's title:\n");   
	fgets(playlistTitle, 50, stdin);   
	printf("\n");   
	// Eliminate end-of-line char   
	playlistTitle[strlen(playlistTitle) - 1] = '\0';   

	// Output play list menu options   
	PrintMenu(playlistTitle);   

	while(menuOp != 'q') {      
		printf("Choose an option:\n");      
		scanf(" %c", &menuOp);      
		if (menuOp == 'a' || menuOp == 'r' || menuOp == 'o') {         
			headNode = ExecuteMenu(menuOp, playlistTitle, headNode);         
			PrintMenu(playlistTitle);      
		}   
	}
	return 0;
}   


