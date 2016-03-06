/*
 * RamFile.c
 *
 *  Created on: Mar 6, 2016
 *      Author: cybermilitia
 */

#include "./RamFile.h"
/**
*@brief	Kacis fonksiyonu
*
*@param Signal
*
*@return NA
*/
void redisSig(int sig)
{
    fprintf(stderr, "\n\nhata: %s%s%s sinyali geldi.\n\n", red, strsignal(sig), none);
    if(sig == SIGINT)
    {
    	exit (EXIT_FAILURE);
    }

    if(sig == SIGHUP)
    {
        // config_read() oku.
        return;
    }

    INFO("KILL sinyali geldi!!");
    exit(EXIT_FAILURE);
}


int redis()
{
	char * insert_command;

	insert_command = malloc(sizeof(1024));
	sprintf(insert_command,
			"INSERT INTO \"NODE-software\" VALUES (%s, '%s', '%s', '%s', '%s', '%s', \
			'%s', '%s','%s', '%s', %d, \
			'%s', '%s','%s', '%s','%s', '%s', \
			'%s', '%s', '%s', '%s');" \
			,ms4db_ptr->resourceType ,ms4db_ptr->name, m2mSmGenerateRandomId(BIG_SIZE), (char *)ms4db_ptr->creationTime, (char *)ms4db_ptr->lastModifiedTime, "",\
			"", (char *)ms4db_ptr->expirationTime,"", "", ms4db_ptr->mgmtDefinition, \
			ms4db_ptr->name, "/opt/m2m/update/", "", ms4db_ptr->version, ms4db_ptr->name, ms4db_ptr->url, \
		    ms4db_ptr->install?"true":"false", ms4db_ptr->uninstall?"true":"false", ms4db_ptr->activate?"true":"false", ms4db_ptr->deactivate?"true":"false");

	resultPtr = execCommand(conPtr, insert_command);
	DEBUG("Command: %s", insert_command);

	if(resultPtr != NULL)
	{
		free(resultPtr);
	}
	return 1;
}

/**
 * @brief Redis Main process
 *
 * @param -
 *
 */
int main(int argc, char *argv[])
{
	//mtrace();
	int result =1;

	/*Sinyal yakalama*/
	signal(SIGINT, RedisSig);

	redis();

	return result;
}


