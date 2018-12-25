//------------------------------------------------
//-----------SFTA: San Fierro Theft Auto----------
//---------Game Mode for SA-MP by KKMZero---------
//------------------------------------------------

#include <a_samp>
#include <i_sampp>
#include <YSI-Includes-4.x\YSI\y_ini>

//---------------GLOBAL DEFINES-------------------
#define SFTA_VERSION "v0.3.4"

//-------------------PICKUPS----------------------
new pickupPoliceSF;

new yarrowPoliceSF;
new yarrowPoliceSFExit;

//----------------DIALOG: JOBS--------------------
#define DIALOG_JOB_SF_POLICE_ISHIRED 900
#define DIALOG_JOB_SF_POLICE 901
#define DIALOG_JOB_SF_POLICE_PICKSKIN 902

//---------------JOB ID DEFINES-------------------
#define JOB_NONE 0
#define JOB_SF_POLICE 1

//LOGIN SYSTEM//
#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_SUCCESS_1 3
#define DIALOG_SUCCESS_2 4
#define PATH "sfta/save/%s.ini"


enum pInfo
{
    pPass,
    pCash,
    pAdmin,
    pKills,
    pDeaths,
    pJob,
    pSkinID,
    
    //Weapon Slots + Ammo
    pWeapon1,
    pWeapon1a,
    pWeapon2,
    pWeapon2a,
    pWeapon3,
    pWeapon3a,
    pWeapon4,
    pWeapon4a,
    pWeapon5,
    pWeapon5a,
    pWeapon6,
    pWeapon6a,
    pWeapon7,
    pWeapon7a,
    pWeapon8,
    pWeapon8a,
    pWeapon9,
    pWeapon9a,
    pWeapon10,
    pWeapon10a,
    pWeapon11,
	pWeapon11a,
    pWeapon12,
    pWeapon12a,
}
new PlayerInfo[MAX_PLAYERS][pInfo];

forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
	INI_Int("Password",PlayerInfo[playerid][pPass]);
	INI_Int("Cash",PlayerInfo[playerid][pCash]);
	INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
	INI_Int("Kills",PlayerInfo[playerid][pKills]);
    INI_Int("Deaths",PlayerInfo[playerid][pDeaths]);
    INI_Int("Job",PlayerInfo[playerid][pJob]);
    INI_Int("SkinID",PlayerInfo[playerid][pSkinID]);
    
    INI_Int("Weapon1",PlayerInfo[playerid][pWeapon1]);
    INI_Int("Weapon1Ammo",PlayerInfo[playerid][pWeapon1a]);
    INI_Int("Weapon2",PlayerInfo[playerid][pWeapon2]);
    INI_Int("Weapon2Ammo",PlayerInfo[playerid][pWeapon2a]);
    INI_Int("Weapon3",PlayerInfo[playerid][pWeapon3]);
    INI_Int("Weapon3Ammo",PlayerInfo[playerid][pWeapon3a]);
    INI_Int("Weapon4",PlayerInfo[playerid][pWeapon4]);
    INI_Int("Weapon4Ammo",PlayerInfo[playerid][pWeapon4a]);
    INI_Int("Weapon5",PlayerInfo[playerid][pWeapon5]);
    INI_Int("Weapon5Ammo",PlayerInfo[playerid][pWeapon5a]);
    INI_Int("Weapon6",PlayerInfo[playerid][pWeapon6]);
    INI_Int("Weapon6Ammo",PlayerInfo[playerid][pWeapon6a]);
    INI_Int("Weapon7",PlayerInfo[playerid][pWeapon7]);
    INI_Int("Weapon7Ammo",PlayerInfo[playerid][pWeapon7a]);
    INI_Int("Weapon8",PlayerInfo[playerid][pWeapon8]);
    INI_Int("Weapon8Ammo",PlayerInfo[playerid][pWeapon8a]);
    INI_Int("Weapon9",PlayerInfo[playerid][pWeapon9]);
    INI_Int("Weapon9Ammo",PlayerInfo[playerid][pWeapon9a]);
    INI_Int("Weapon10",PlayerInfo[playerid][pWeapon10]);
    INI_Int("Weapon10Ammo",PlayerInfo[playerid][pWeapon10a]);
    INI_Int("Weapon11",PlayerInfo[playerid][pWeapon11]);
    INI_Int("Weapon11Ammo",PlayerInfo[playerid][pWeapon11a]);
    INI_Int("Weapon12",PlayerInfo[playerid][pWeapon12]);
    INI_Int("Weapon1Ammo",PlayerInfo[playerid][pWeapon1a]);
 	return 1;
}

stock UserPath(playerid)
{
	new string[128],playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
	format(string,sizeof(string),PATH,playername);
	return string;
}

stock udb_hash(buf[]) {
	new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}
//END LOGIN SYSTEM//


#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" SFTA: San Fierro Theft Auto");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" SFTA: San Fierro Theft Auto");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	SetGameModeText("SFTA "SFTA_VERSION"");
	
	AddPlayerClass(SKIN_CJ, -1606.8878, 717.8130, 12.2245, 358.9309, 0, 0, 0, 0, 0, 0);
	
	//SF FIXED PICKUPS SPAWN LOCATIONS
	pickupPoliceSF = CreatePickup(PICKUP_KEYCARD, 1, -1614.5913, 714.1862, 13.6163, -1);

	yarrowPoliceSF = CreatePickup(PICKUP_YELLOWENMARKER, 1, -1605.4822, 711.0074, 13.8672+0.5, -1);
	yarrowPoliceSFExit = CreatePickup(PICKUP_YELLOWENMARKER, 1, 246.3033, 108.8014, 1003.2188+0.5, -1);
	
	//SF FIXED CAR SPAWN LOCATIONS
	AddStaticVehicle(VEH_COPCARSF,-1594.5317,673.6928,6.9547,1.0495,0,1);
	AddStaticVehicle(VEH_COPCARSF,-1610.2531,651.7255,6.9569,176.7788,0,1);
	AddStaticVehicle(VEH_COPCARSF,-1592.2277,748.4681,-5.4734,177.1311,0,1);
	AddStaticVehicle(VEH_COPCARSF,-1638.6682,682.3401,-5.4734,91.6074,0,1);
	AddStaticVehicle(VEH_COPBIKE,-1587.0393,672.8373,6.7533,181.1274,0,0);
	AddStaticVehicle(VEH_COPBIKE,-1589.7200,673.0420,6.7583,182.1457,0,0);
	AddStaticVehicle(VEH_POLMAV,-1679.8846,706.0021,30.7769,79.4707,0,1);
	AddStaticVehicle(VEH_SWATVAN,-1612.4661,732.2926,-5.4816,357.3998,1,1);
	AddStaticVehicle(VEH_SWATVAN,-1616.6752,732.6617,-5.4794,359.8055,1,1);
	AddStaticVehicle(VEH_ENFORCER,-1605.9714,733.1621,-5.1049,358.7123,0,1);
	AddStaticVehicle(VEH_ENFORCER,-1600.1976,676.3246,-5.1085,1.9666,0,1);
	
	AddStaticVehicle(VEH_AMBULANCE,-2651.5774,594.2109,14.6029,271.1118,1,3);
	
	AddStaticVehicle(VEH_TAXI,-1987.8477,117.0142,27.3195,359.5417,6,1);
	AddStaticVehicle(VEH_TAXI,-1987.9342,127.3036,27.3197,0.1040,6,1);
	AddStaticVehicle(VEH_TAXI,-1988.0581,163.5928,27.3186,358.7466,6,1);
	AddStaticVehicle(VEH_COACH,-1988.4558,147.1401,27.6737,359.3782,79,7);
	
	AddStaticVehicle(VEH_FIRETRUCK,-2022.5950,92.4361,28.3424,270.9305,3,1);
	AddStaticVehicle(VEH_FIRETRUCK,-2022.3732,84.1860,28.2939,269.5228,3,1);
	AddStaticVehicle(VEH_FIRETRUCK,-2053.3821,84.4713,28.6285,90.7700,3,1);
	AddStaticVehicle(VEH_FIRETRUCKLA,-2065.8965,56.0458,28.7598,0.1295,3,1);

	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, -2073.6345, 450.1090, 139.7422);
	SetPlayerFacingAngle(playerid, 176.5343);
	SetPlayerCameraPos(playerid, -2073.6345 ,446.9046, 139.7422);
	SetPlayerCameraLookAt(playerid, -2073.2676, 456.1090, 139.7422);
	return 1;
}

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~SFTA "SFTA_VERSION"",3000,4);
  	SendClientMessage(playerid,COLOR_WHITE,"Welcome to {88AA88}SFTA{FFFFFF} "SFTA_VERSION"");
  	
  	if(fexist(UserPath(playerid))) {
		INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
  		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,""SCOL_WHITE"Login",""SCOL_WHITE"Type your password below to login.","Login","Quit");
	}
	else {
 		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,""SCOL_WHITE"Registering...",""SCOL_WHITE"Type your password below to register a new account.","Register","Quit");
	}
	
	//---------------SHOW MAP ICONS-------------------
	SetPlayerMapIcon(playerid, ICON_POLICE, -1614.5913, 714.1862, 13.6163, 30, 0, MAPICON_LOCAL);
	
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Cash",GetPlayerMoney(playerid));
	INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
	INI_WriteInt(File,"Kills",PlayerInfo[playerid][pKills]);
	INI_WriteInt(File,"Deaths",PlayerInfo[playerid][pDeaths]);
	INI_WriteInt(File,"Job",PlayerInfo[playerid][pJob]);
	INI_WriteInt(File,"SkinID",PlayerInfo[playerid][pSkinID]);
	
	GetPlayerWeaponData(playerid, 1, PlayerInfo[playerid][pWeapon1], PlayerInfo[playerid][pWeapon1a]);
	GetPlayerWeaponData(playerid, 2, PlayerInfo[playerid][pWeapon2], PlayerInfo[playerid][pWeapon2a]);
	GetPlayerWeaponData(playerid, 3, PlayerInfo[playerid][pWeapon3], PlayerInfo[playerid][pWeapon3a]);
	GetPlayerWeaponData(playerid, 4, PlayerInfo[playerid][pWeapon4], PlayerInfo[playerid][pWeapon4a]);
	GetPlayerWeaponData(playerid, 5, PlayerInfo[playerid][pWeapon5], PlayerInfo[playerid][pWeapon5a]);
	GetPlayerWeaponData(playerid, 6, PlayerInfo[playerid][pWeapon6], PlayerInfo[playerid][pWeapon6a]);
	GetPlayerWeaponData(playerid, 7, PlayerInfo[playerid][pWeapon7], PlayerInfo[playerid][pWeapon7a]);
	GetPlayerWeaponData(playerid, 8, PlayerInfo[playerid][pWeapon8], PlayerInfo[playerid][pWeapon8a]);
	GetPlayerWeaponData(playerid, 9, PlayerInfo[playerid][pWeapon9], PlayerInfo[playerid][pWeapon9a]);
	GetPlayerWeaponData(playerid, 10, PlayerInfo[playerid][pWeapon10], PlayerInfo[playerid][pWeapon10a]);
	GetPlayerWeaponData(playerid, 11, PlayerInfo[playerid][pWeapon11], PlayerInfo[playerid][pWeapon11a]);
	GetPlayerWeaponData(playerid, 12, PlayerInfo[playerid][pWeapon12], PlayerInfo[playerid][pWeapon12a]);
	
	INI_WriteInt(File,"Weapon1",PlayerInfo[playerid][pWeapon1]);
	INI_WriteInt(File,"Weapon1Ammo",PlayerInfo[playerid][pWeapon1a]);
	INI_WriteInt(File,"Weapon2",PlayerInfo[playerid][pWeapon2]);
	INI_WriteInt(File,"Weapon2Ammo",PlayerInfo[playerid][pWeapon2a]);
	INI_WriteInt(File,"Weapon3",PlayerInfo[playerid][pWeapon3]);
	INI_WriteInt(File,"Weapon3Ammo",PlayerInfo[playerid][pWeapon3a]);
	INI_WriteInt(File,"Weapon4",PlayerInfo[playerid][pWeapon4]);
	INI_WriteInt(File,"Weapon4Ammo",PlayerInfo[playerid][pWeapon4a]);
	INI_WriteInt(File,"Weapon5",PlayerInfo[playerid][pWeapon5]);
	INI_WriteInt(File,"Weapon5Ammo",PlayerInfo[playerid][pWeapon5a]);
	INI_WriteInt(File,"Weapon6",PlayerInfo[playerid][pWeapon6]);
	INI_WriteInt(File,"Weapon6Ammo",PlayerInfo[playerid][pWeapon6a]);
	INI_WriteInt(File,"Weapon7",PlayerInfo[playerid][pWeapon7]);
	INI_WriteInt(File,"Weapon7Ammo",PlayerInfo[playerid][pWeapon7a]);
	INI_WriteInt(File,"Weapon8",PlayerInfo[playerid][pWeapon8]);
	INI_WriteInt(File,"Weapon8Ammo",PlayerInfo[playerid][pWeapon8a]);
	INI_WriteInt(File,"Weapon9",PlayerInfo[playerid][pWeapon9]);
	INI_WriteInt(File,"Weapon9Ammo",PlayerInfo[playerid][pWeapon9a]);
	INI_WriteInt(File,"Weapon10",PlayerInfo[playerid][pWeapon10]);
	INI_WriteInt(File,"Weapon10Ammo",PlayerInfo[playerid][pWeapon10a]);
	INI_WriteInt(File,"Weapon11",PlayerInfo[playerid][pWeapon11]);
	INI_WriteInt(File,"Weapon11Ammo",PlayerInfo[playerid][pWeapon11a]);
	INI_WriteInt(File,"Weapon12",PlayerInfo[playerid][pWeapon12]);
	INI_WriteInt(File,"Weapon12Ammo",PlayerInfo[playerid][pWeapon12a]);

	INI_Close(File);
	
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkinID]);
    
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon1], PlayerInfo[playerid][pWeapon1a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon2], PlayerInfo[playerid][pWeapon2a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon3], PlayerInfo[playerid][pWeapon3a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon4], PlayerInfo[playerid][pWeapon4a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon5], PlayerInfo[playerid][pWeapon5a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon6], PlayerInfo[playerid][pWeapon6a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon7], PlayerInfo[playerid][pWeapon7a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon8], PlayerInfo[playerid][pWeapon8a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon9], PlayerInfo[playerid][pWeapon9a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon10], PlayerInfo[playerid][pWeapon10a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon11], PlayerInfo[playerid][pWeapon11a]);
    GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon12], PlayerInfo[playerid][pWeapon12a]);
    
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	PlayerInfo[killerid][pKills]++;
	PlayerInfo[playerid][pDeaths]++;
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/help", cmdtext, true, 10) == 0) {
		SendClientMessage(playerid,COLOR_WHITE,"[JOBS] /quitjob ");
		return 1;
	}
	
	if (strcmp("/quitjob", cmdtext, true, 10) == 0) {
	    PlayerInfo[playerid][pJob] = JOB_NONE;
		SendClientMessage(playerid,COLOR_GREEN,"You are now unemployed.");
		return 1;
	}
	
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    /*if(pickupid == pickup_Cash)
    {
        GivePlayerMoney(playerid, 1000);
    }
    else if(pickupid == pickup_Health)
    {
        SetPlayerHealth(playerid, 100.0);
    }*/
    
    if(pickupid == pickupPoliceSF) {
        if(PlayerInfo[playerid][pJob] != JOB_SF_POLICE){
			ShowPlayerDialog(playerid, DIALOG_JOB_SF_POLICE, DIALOG_STYLE_MSGBOX, "San Fierro Police Department", "Do you want to apply for this job?", "Apply", "Close");
		}
		else {
			//ShowPlayerDialog(playerid, DIALOG_JOB_SF_POLICE_ISHIRED, DIALOG_STYLE_MSGBOX, "San Fierro Police Department", "Change Player Skin?", "Yes", "Close");
			ShowPlayerDialog(playerid, DIALOG_JOB_SF_POLICE_ISHIRED, DIALOG_STYLE_LIST, "Options", "Change Player Skin\nRefill Ammo", "Pick", "Close");
		}
    }
    else if(pickupid == yarrowPoliceSF) {
        ISAMPP_TELEPORT(playerid, LOC_SFPDHQ);
    }
    else if(pickupid == yarrowPoliceSFExit) {
        	SetPlayerPos(playerid, -1606.8878, 717.8130, 12.2245);
			SetPlayerFacingAngle(playerid, 358.9309);
			SetPlayerInterior(playerid, 0);
    }
    
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid ) {
        case DIALOG_REGISTER: {
            if (!response) return Kick(playerid);
            if(response) {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, ""SCOL_WHITE"Registering...",""SCOL_RED"You have entered an invalid password.\n"SCOL_WHITE"Type your password below to register a new account.","Register","Quit");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File,"Cash",0);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Kills",0);
                INI_WriteInt(File,"Deaths",0);
                INI_WriteInt(File,"Job",0);
                INI_WriteInt(File,"SkinID",0);
                
                INI_WriteInt(File,"Weapon1",0);
                INI_WriteInt(File,"Weapon1Ammo",0);
            	INI_WriteInt(File,"Weapon2",0);
                INI_WriteInt(File,"Weapon3Ammo",0);
                INI_WriteInt(File,"Weapon3",0);
                INI_WriteInt(File,"Weapon3Ammo",0);
                INI_WriteInt(File,"Weapon4",0);
                INI_WriteInt(File,"Weapon4Ammo",0);
                INI_WriteInt(File,"Weapon5",0);
                INI_WriteInt(File,"Weapon5Ammo",0);
                INI_WriteInt(File,"Weapon6",0);
                INI_WriteInt(File,"Weapon6Ammo",0);
                INI_WriteInt(File,"Weapon7",0);
                INI_WriteInt(File,"Weapon7Ammo",0);
                INI_WriteInt(File,"Weapon8",0);
                INI_WriteInt(File,"Weapon8Ammo",0);
                INI_WriteInt(File,"Weapon9",0);
                INI_WriteInt(File,"Weapon9Ammo",0);
                INI_WriteInt(File,"Weapon10",0);
                INI_WriteInt(File,"Weapon10Ammo",0);
                INI_WriteInt(File,"Weapon11",0);
                INI_WriteInt(File,"Weapon11Ammo",0);
             	INI_WriteInt(File,"Weapon12",0);
                INI_WriteInt(File,"Weapon12Ammo",0);
                
                INI_Close(File);

                SpawnPlayer(playerid);
                ShowPlayerDialog(playerid, DIALOG_SUCCESS_1, DIALOG_STYLE_MSGBOX,""SCOL_WHITE"Success!",""SCOL_GREEN"Great! You have been registered. Relog to save your stats!","Ok","");
			}
        }

        case DIALOG_LOGIN: {
            if ( !response ) return Kick ( playerid );
            if( response ) {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPass]) {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
					SendClientMessage(playerid,COLOR_GREEN,"You are successfully logged in!");
                }
                else {
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,""SCOL_WHITE"Login",""SCOL_RED"You have entered an incorrect password.\n"SCOL_WHITE"Type your password below to login.","Login","Quit");
                }
                return 1;
            }
        }
        
        
        //[JOBS]

		//JOB SF POLICE
		case DIALOG_JOB_SF_POLICE: {
		    if(response) {
            	SendClientMessage(playerid, COLOR_GREEN, "You Are Hired.");
            	PlayerInfo[playerid][pJob] = JOB_SF_POLICE;
            	SetPlayerSkin(playerid, SKIN_SFPD1); PlayerInfo[playerid][pSkinID] = SKIN_SFPD1;
				GivePlayerWeapon(playerid, WEAP_TEARGAS, 5);
				GivePlayerWeapon(playerid, WEAP_PISTOL, 340);
				GivePlayerWeapon(playerid, WEAP_SHOTGUN, 80);
				GivePlayerWeapon(playerid, WEAP_MP5, 420);
        	}
        	else {
        	}
        	return 1;
		}
		
		case DIALOG_JOB_SF_POLICE_ISHIRED: {
			if(response) {
				switch(listitem) {
				    case 0: { ShowPlayerDialog(playerid, DIALOG_JOB_SF_POLICE_PICKSKIN, DIALOG_STYLE_LIST, "Skin Selector", "SFPD Officer (M)\nSFPD Officer 2 (M)\nSFPD Officer (F)\nMotorbike Cop\nS.W.A.T Special Forces", "Pick", "Close"); }
		            case 1: { ResetPlayerWeapons(playerid); GivePlayerWeapon(playerid, WEAP_TEARGAS, 5); GivePlayerWeapon(playerid, WEAP_PISTOL, 340); GivePlayerWeapon(playerid, WEAP_SHOTGUN, 80); GivePlayerWeapon(playerid, WEAP_MP5, 420); }
				}
			}
			else {
			}
			return 1;
		
		/*	if(response) {
				ShowPlayerDialog(playerid, DIALOG_JOB_SF_POLICE_PICKSKIN, DIALOG_STYLE_LIST, "Skin Selector", "SFPD Officer (M)\nSFPD Officer 2 (M)\nSFPD Officer (F)\nMotorbike Cop\nS.W.A.T Special Forces", "Pick", "Close");
        	}
        	else {
        	}
        	return 1;*/
		}
		
		case DIALOG_JOB_SF_POLICE_PICKSKIN: {
		    if(response) {
		        if(dialogid == DIALOG_JOB_SF_POLICE_PICKSKIN && response == 1) {
					switch(listitem) {
					case 0: { SetPlayerSkin(playerid, SKIN_SFPD1); PlayerInfo[playerid][pSkinID] = SKIN_SFPD1; }
					case 1: { SetPlayerSkin(playerid, SKIN_SFPDNA); PlayerInfo[playerid][pSkinID] = SKIN_SFPDNA; }
					case 2: { SetPlayerSkin(playerid, SKIN_VBFYCPD); PlayerInfo[playerid][pSkinID] = SKIN_VBFYCPD; }
					case 3: { SetPlayerSkin(playerid, SKIN_LAPDM1); PlayerInfo[playerid][pSkinID] = SKIN_LAPDM1; }
					case 4: { SetPlayerSkin(playerid, SKIN_SWAT); PlayerInfo[playerid][pSkinID] = SKIN_SWAT; }
					}
				}
		    }
			else {
			}
			return 1;
		}
		//END JOB SF POLICE
		
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
