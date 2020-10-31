#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

ConVar g_CvarSmnextmap = null;

public Plugin myinfo = {
    name        = "TF2 Built-in Vote sm_nextmap bug fix",
    author      = "Jobggun",
    description = "Making TF2 Built-in vote work well with sourcemod nextmap plugin",
    version     = "1.0.0",
    url         = ""
};

public void OnPluginStart()
{
    g_CvarSmnextmap = FindConVar("sm_nextmap");
    
    HookUserMessage(GetUserMessageId("VotePass"), Hook_ChangeLevel, true);
}

public Action Hook_ChangeLevel(UserMsg msg_id, BfRead msg, const int[] players, int playersNum, bool reliable, bool init)
{
    
    int team;
    char reason[256];
    char map[256];
    
    team = msg.ReadByte();
    msg.ReadString(reason, sizeof(reason), false);
    msg.ReadString(map, sizeof(map), false);
    
    if(!StrEqual(reason, "#TF_vote_passed_changelevel", false))
    {
        return Plugin_Continue;
    }
    
    g_CvarSmnextmap.SetString(map, false, true);
    
    return Plugin_Continue;
}