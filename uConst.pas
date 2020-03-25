unit uConst;
interface
uses Messages;

type
  TScriptBlock = record
                   ScriptName: string;
                   LineNr: array[0..1] of integer;
                 end;
  TScriptBlocks = array of TScriptBlock;               



const
  cLineSpacing = 1;

  ETDelimiters : array[0..3] of string = (
                    ' ',
                    ''+#9,
                    ''+#13,
                    ''+#10
                  );
(*
  HighLights : array[0..2] of  = (
                    '',
                    '',
                    ''
                  );
*)
  Commands : array[0..92] of string = (
                    'setglobalfog',
                    'spawnrubble',
                    'setautospawn',

                    'mu_fade',
                    'mu_play',
                    'mu_queue',
                    'mu_start',
                    'mu_stop',

                    'aiscriptname',
                    'disablemessage',
                    'removebot',
                    'setbotgoalpriority',
                    'setbotgoalstate',
                    'setaasstate',
                    'spawnbot',

                    'wm_allied_respawntime',
                    'wm_axis_respawntime',
                    'wm_endround',
                    'wm_set_defending_team',
                    'wm_set_round_timelimit',
                    'wm_setwinner',

                    'accum',
                    'globalaccum',
                    'cvar',

                    'botdebugging',
                    'entityscriptname',
                    'print',
                    'printaccum',
                    'printglobalaccum',
                    'setdebuglevel',

                    'abortifnotsingleplayer',
                    'abortifwarmup',
                    'resetscript',
                    'trigger',
                    'wait',

                    'alertentity',
                    'kill',
                    'remove',

                    'wm_announce',
                    'wm_announce_icon',
                    'wm_voiceannounce',
                    'wm_addteamvoiceannounce',
                    'wm_removeteamvoiceannounce',
                    'wm_teamvoiceannounce',

                    'wm_objective_status',
                    'wm_number_of_objectives',
                    'wm_set_main_objective',

                    'attachtotag',
                    'changemodel',
                    'remapshader',
                    'remapshaderflush',
                    'setstate',

                    'abortmove',
                    'attatchtotrain',
                    'faceangles',
                    'followpath',
                    'followspline',
                    'gotomarker',
                    'halt',
                    'setposition',
                    'setrotation',
                    'setspeed',
                    'stoprotation',

                    'SetInitialCamera',
                    'startcam',
                    'stopcam',

                    'freezeanimation',
                    'playanim',
                    'startanimation',
                    'unfreezeanimation',

                    'setchargetimefactor',
                    'sethqstatus',

                    'addtankammo',
                    'allowtankenter',
                    'allowtankexit',
                    'setdamagable',
                    'settankammo',

                    'construct',
                    'constructible_chargebarreq',
                    'constructible_class',
                    'constructible_constructxpbonus',
                    'constructible_destructxpbonus',
                    'constructible_duration',
                    'constructible_health',
                    'constructible_weaponclass',
                    'repairmg42',
                    'setmodelfrombrushmodel',

                    'disablespeaker',
                    'enablespeaker',
                    'fadeallsounds',
                    'playsound',
                    'stopsound',
                    'togglespeaker'
                  );

  ReservedWords : array[0..62] of string = (
                    'wait',
                    'bitreset',
                    'bitset',
                    'inc',
                    'random',
                    'set',
                    'set_to_dynamitecount',
                    'abort_if_bitset',
                    'abort_if_equal',
                    'abort_if_greater_than',
                    'abort_if_less_than',
                    'abort_if_not_bitset',
                    'abort_if_not_equal',
                    'trigger_if_equal',
                    'wait_while_equal',
                    'self',
                    'global',
                    'default',
                    'invisible',
                    'underconstruction',
                    'yes',
                    'no',
                    'down',
                    'up',
                    'looping',
                    'volume',
                    'useoriginforpvs',
                    'nonsolid',
                    'norandom',
                    'nolerp',
                    'noloop',
                    'untilreachmarker',
                    'forever',
                    'rate',
                    'black',
                    'gravity',
                    'lowgravity',
                    'accel',
                    'deccel',
                    'turntotarget',
                    'relative',
                    'length',
                    'roll',
                    'dampin',
                    'dampout',
                    'gototime',
                    'enabled',
                    'disabled',
                    'avoid',
                    'axis',
                    'allies',
                    'both',
                    'active',
                    'inactive',
                    'level',
                    'player',
                    'activator',
                    'soldier',
                    'medic',
                    'engineer',
                    'fieldops',
                    'covertops',
                    'lieutenant'
                  );

  //<eventname>                
  Events : array[0..12] of string = (
                    'spawn',
                    'buildstart',  // stage1, stage2, stage3, final
                    'built',       // Events5 ^^
                    'decayed',     // Events5
                    'destroyed',   // Events5
                    'death',
                    'pain',
                    'rebirth',
                    'dynamited',
                    'defused',
                    'trigger',     // Events2
                    'activate',    // Events3
                    'mg42'         // Events4
                  );
  //<eventname>
  Events_ : array[0..6] of string = (
                    'trigger',     // Events2
                    'activate',    // Events3
                    'mg42',        // Events4
                    'buildstart',  // Events5
                    'built',       // Events5
                    'decayed',     // Events5
                    'destroyed'    // Events5
                  );

  // trigger <eventname>
  Events2 : array[0..12] of string = (
                    'allied_object_dropped',
                    'allied_object_returned',
                    'allied_object_stolen',
                    'axis_object_dropped',
                    'axis_object_returned',
                    'axis_object_stolen',
                    'timelimit_hit',
                    'allied_capture',
                    'axis_capture',
                    'stolen',
                    'dropped',
                    'returned',
                    'captured'
                  );

  // activate <eventname>
  Events3 : array[0..1] of string = (
                    'allies',
                    'axis'
                  );

  // mg42 <eventname>
  Events4 : array[0..1] of string = (
                    'mount',
                    'unmount'
                  );

  // [buildstart|built|decayed|destroyed] <eventname>
  Events5 : array[0..3] of string = (
                    'stage1',
                    'stage2',
                    'stage3',
                    'final'
                  );

implementation

end.
