MxM_Pj_S = {

    AddVehicle = {
        table = "owned_vehicles",
    },

    ESX = {
        skinTrigger         = "esx_skin:openRestrictedMenu", 
        ReviveTrigger       = "Your_Trigger",
        HealTrigger         = "Your_Trigger",
    },
}

MxM_Pj_Admin_Menu_table = {

    Log = {
        Discord = {
            enable = true,
            webhook_image   = "Your Webhook",
            webhook_ban     = "Your Webhook",
            webhook_admin   = "Your Webhook",
        },
    },

    Vehicle = {
            {label = "Ferrari",     value = "blista"},
            {label = "Rumpo",       value = "rumpo"},
            {label = "T20",         value = "t20"},

    },

    Permission = {

        Ban = {
            ["admin"] = true
        },

        Sban = {
            ["admin"] = true
        },

        Kick = {

            ["admin"] = true
        },

        Crash = {

            ["admin"] = true
        },

        Skin = {

            ["admin"] = true
        },

        Heal = {

            ["admin"] = true
        },

        Revive = {

            ["admin"] = true
        },

        Giubbo = {

            ["admin"] = true
        },
        
        TpToWp = {

            ["admin"] = true
        },

        Kill = {

            ["admin"] = true
        },

        FreeCam = {

            ["admin"] = true
        },

        TpDate = {

            ["admin"] = true
        },

        TpTo = {

            ["admin"] = true
        },

        DelVeh = {

            ["admin"] = true
        },

        DelPed = {

            ["admin"] = true
        },

        DelProps = {

            ["admin"] = true
        },

        DelAll = {

            ["admin"] = true
        },

        NoClip = {

            ["admin"] = true
        },

        Screen = {

            ["admin"] = true
        },

        OfflineBan = {
            ["admin"] = true

        },
        Godmode = {
            ["admin"] = true

        },
        Open = {
            ["admin"] = true

        },
        Blip = {
            ["admin"] = true

        },
        Nomi = {
            ["admin"] = true

        },
        Wash = {
            ["admin"] = true

        },
        AddCar = {
            ["admin"] = true

        },

        GiveMoney  = {
            ["admin"] = true

        },

        Reviveall  = {
            ["admin"] = true

        },

        Wipe  = {
            ["admin"] = true

        },

        TempBan  = {
            ["admin"] = true

        },

        Offlinetempban  = {
            ["admin"] = true

        },
    },


    IdentiFier = {

        Ban = {
            "steam:8673928176"
        },

        Sban = {
            "steam:8673928176"
        },

        Kick = {

            "steam:8673928176"
        },

        Crash = {

            "steam:8673928176"
        },

        Skin = {

            "steam:8673928176"
        },

        Heal = {

            "steam:8673928176"
        },

        Revive = {

            "steam:8673928176"
        },
        
        Giubbo = {

            "steam:8673928176"
        },
        
        TpToWp = {

            "steam:8673928176"
        },

        Kill = {

            "steam:8673928176"
        },

        FreeCam = {

            "steam:8673928176"
        },

        TpDate = {

            "steam:8673928176"
        },

        TpTo = {

            "steam:8673928176"
        },

        DelVeh = {

            "steam:8673928176"
        },

        DelPed = {

            "steam:8673928176"
        },

        DelProps = {

            "steam:8673928176"
        },

        DelAll = {

            "steam:8673928176"
        },

        NoClip = {

            "steam:8673928176"
        },

        Screen = {

            "steam:8673928176"
        },

        OfflineBan = {

          "steam:8673928176"

        },

        Godmode = {
            "steam:8673928176"

        },

        Open = {
            "steam:8673928176"

        },
        Blip = {
            "steam:8673928176"

        },
        Nomi = {
            "steam:8673928176"

        },
        Wash = {
            "steam:8673928176"

        },
        AddCar = {
            "steam:8673928176"

        },
        GiveMoney  = {
            "steam:8673928176"

        },

        Reviveall  = {
            "steam:8673928176"

        },

        Wipe  = {
            "steam:8673928176"

        },

        TempBan  = {
            "steam:8673928176"

        },

        Offlinetempban  = {
            "steam:8673928176"

        },

    }
}



 
MenuConfig = {  

    Element = {

        HomeMenu = {

            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},
                label = MxM_Lang["lista_player"], 	        
                value = "mxm:ListaPlayer", 	
                serverside = false,	
                sub = false, 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["open_menu_da_id"], 	    
                value = "mxm:opnemenuid", 	
                serverside = false,	
                sub = false, 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},
                label = MxM_Lang["self_menu"], 	        
                value = "", 	
                serverside = false,	
                sub = true, 
                namesub = "submenu_self_menu"
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["open_skin_menu"], 	    
                value = "mxm:skin_menu", 	
                serverside = true,	
                sub = false, 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["open_vehicle_menu"], 	    
                value =  "", 	            
                serverside = false,	
                sub = true , 
                namesub = "submenu_vehicle"
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["open_clear_menu"], 	    
                value =  "", 	            
                serverside = false,	
                sub = true , 
                namesub = "submenu_clear"
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["list_ban"], 	    
                value =  "mxm:listban", 	            
                serverside = false,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = "Credits", 	    
                value =  "mxm:credits", 	            
                serverside = false,	
                sub = false , 
                namesub = ""
            },

        },

        listplayer = {

            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["amministrazione"], 	       
                value = "",      
                serverside = false,	
                sub = true, 
                namesub = "submenu_amministrazione"},
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["gestione"], 	                
                value = "",  	  
                serverside = false,	
                sub = true, 
                namesub = "submenu_gestione"
            },
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["varie"],                      
                value = "",  	  
                serverside = false,	
                sub = true, 
                namesub = "submenu_varie"
            },
        },
    },

    SubMenu = {

        submenu_vehicle = { 

            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["ripara_vehicle"], 	    
                value = "mxm:ripara_vehicle", 	      
                serverside = false,	
                sub = false, 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["spawn_vehicle"], 	        
                value = "mxm:spawn_vehicle", 	      
                serverside = false,	
                sub = false, 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["gira_vehicle"],           
                value = "mxm:gira_vehicle", 	      
                serverside = false,	
                sub = false, 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["del_vehicle"],            
                value = "mxm:del_vehicle", 	          
                serverside = false,	
                sub = false, 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["fulkit"], 	    
                value = "mxm:fulkit", 	  
                serverside = true,	
                sub = false, 
                namesub = ""
            },
        },

        submenu_clear = {

            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["ped_clear"], 	       
                value = "mxm:ped_clear",           
                serverside = true,	
                sub = false, 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["vehicle_clear"], 	  
                value = "mxm:vehicle_clear", 	  
                serverside = true,	
                sub = false, 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["props_clear"],       
                value = "mxm:props_clear", 	      
                serverside = true,	
                sub = false, 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	 	
                label = MxM_Lang["all_clear"],        
                    value = "mxm:all_clear", 	      
                    serverside = true, 
                    sub = false, 
                    namesub = ""
            },

        },

        submenu_amministrazione = {

            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["ban_player"], 	          
                value =  "mxm:banplayer", 	
                serverside = false,	
                sub = false , 
                namesub = ""
            }, 
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["kick_player"], 	          
                value =  "mxm:kickplayer",    
                serverside = false,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["crash_player"], 	          
                value =  "mxm:crash_player",  
                serverside = true,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["info_player"], 	          
                value =  "mxm:info_player", 	
                serverside = false,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["info_su_ds_player"], 	      
                value =  "nil", 	            
                serverside = false,	
                sub = false , 
                namesub = ""
            },           
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["screen_su_ds_player"], 	 
                value =  "mxm:screen", 	
                serverside = true,	
                sub = false , 
                namesub = ""
            },

        },
        
        submenu_gestione = {
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["spectate_freecam"], 	  
                value = "mxm:freecam", 	  
                serverside = true,	
                sub = false,  
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	
                label = MxM_Lang["dai_skin_menu"], 	      
                value =  "mxm:skin_menu", 	            
                serverside = true,	
                sub = false , 
                namesub = ""
            },

            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["tp_to_player"], 	      
                value = "mxm:tpto", 	  
                serverside = true,	
                sub = false,  
                namesub = ""
            },
            {
                
                group = {"superadmin","admin","mod"}, 
                identifier = {"steam:"},	
                label = MxM_Lang["tp_da_te"], 	          
                value = "mxm:tpdate", 	    
                serverside = true,	
                sub = false,  
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["tp_player_su_wp"], 	    
                value =  "mxm:tptowp", 	            
                serverside = true,	
                ub = false , 
                namesub = ""
            },


            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["kill_player"], 	      
                value =  "mxm:kill", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["revive_player"], 	    
                value =  "mxm:revive", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["full_status"], 	     
                value =  "mxm:heal",	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["dai_giubbo"], 	      
                value = "mxm:giubbo", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },


        },
        
        submenu_varie = {

            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["give_money"], 	      
                value =  "mxm:givemoney", 	              
                serverside = false,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"}, 	
                identifier = {"steam:"},
                label = MxM_Lang["set_job"], 	          
                value =  "nil", 	              
                serverside = false,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["give_auto"], 	        
                value =  "mxm:givecar", 	              
                serverside = false,	
                sub = false , 
                namesub = ""
            },
        },


        submenu_self_menu = {  



            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["blip"], 	   
                value =  "mxm:blip", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },

            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["nomi"], 	   
                value =  "mxm:nomi", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },

            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["noclip"], 	   
                value =  "mxm:noclip", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["tp_to_wp"], 	   
                value =  "mxm:tptowp", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["godmode"], 	   
                value =  "mxm:godmode", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["curati"] , 	        
                value =  "mxm:revive", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["sfamati"], 	        
                value =  "mxm:heal", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["give_weapon"], 	        
                value =  "MxM:GiveWeapon", 	              
                serverside = false,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["pulisciti"], 	        
                value =  "mxm:wash", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },
            {
                group = {"superadmin","admin","mod"},       
                identifier = {"steam:"},	
                label = MxM_Lang["giubbo"], 	        
                value =  "mxm:giubbo", 	              
                serverside = true,	
                sub = false , 
                namesub = ""
            },
        }
    }
}