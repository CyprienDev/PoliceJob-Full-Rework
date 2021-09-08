Config                            = {}
Config.Locale = 'fr'

Config.pos = {
	garagevoiture = { -- position du menu garage voiture
		position = {x = 459.94, y = -984.4, z = 24.76}
	},
    rangervoiture = { -- position du menu garage voiture
		position = {x = 442.07, y = -990.73, z = 24.73}
	},
    rangervoiture1 = { -- position du menu garage voiture
		position = {x = 442.1, y = -987.84, z = 24.73}
	},
    rangervoiture2 = { -- position du menu garage voiture
		position = {x = 442.1, y = -984.91, z = 24.73}
	},
    rangervoiture3 = { -- position du menu garage voiture
		position = {x = 442.2, y = -982.16, z = 24.73}
	},
    rangervoiture4 = { -- position du menu garage voiture
		position = {x = 442.03, y = -979.28, z = 24.73}
	},
	garageheli = { -- position du menu garage helico
		position = {x = 462.99, y = -982.13, z = 42.70 }
	},
    coffre = { -- position du menu coffre
		position = {x = 474.14, y = -1006.37, z = 33.24} 
	},
    armurerie = { -- position du menu armurerie
        position = {x = 484.19, y = -1001.92, z = 24.79} 
    },
    vestiaire = { -- position du menu vestiaire
        position = {x = 473.32, y = -987.53, z = 24.77} 
    },
    cam = { -- position du menu caméra
        position = {x = 438.85, y = -991.99, z = 29.72} 
    },
    boss = { -- position du menu boss
        position = {x = 471.57, y = -1005.63, z = 29.72}
    }
}

Config.spawn = {
	voiture = { -- position du spawn de voiture
        position = {x = 459.94, y = -984.4, z = 24.76, h = 358.52},
    },
    spawnheli = { -- position du spawn d'helicoptere
        position = {x = 449.3, y = -981.16, z = 43.69, h = 93.0}
    }
}


Config.armurerie = {
	{nom = "Pistolet de Combat", arme = "combatpistol"}, -- armurerie pour les officier
}

Config.arm = {
	{nom = "Pistolet de Combat", arme = "combatpistol"},
	{nom = "SMG Police", arme = "smg"}, -- armurerie pour les officier jusqu'a lieutenant
}

Config.armi = {
	{nom = "Pistolet de Combat", arme = "combatpistol"},
    {nom = "SMG Police", arme = "smg"},
	{nom = "M4 Police", arme = "carbinerifle"}, -- armurerie pour le commandant
}



police = {
    clothes = {
        specials = {
            [0] = {
                label = "Reprendre sa tenue civil",
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {male = {}, female = {}},
                onEquip = function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                    SetPedArmour(PlayerPedId(), 0)
                end
            },
            [1] = {
                label = "Tenue Cadet",
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 59, ['tshirt_2'] = 0,
                        ['torso_1'] = 55, ['torso_2'] = 0,
                        ['arms'] = 30,
                        ['pants_1'] = 35, ['pants_2'] = 0,
                        ['shoes_1'] =24, ['shoes_2'] = 0,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    },
                    female = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 15,['tshirt_2'] = 2,
                        ['torso_1'] = 65, ['torso_2'] = 2,
                        ['arms'] = 36, ['arms_2'] = 0,
                        ['pants_1'] = 38, ['pants_2'] = 2,
                        ['shoes_1'] = 12, ['shoes_2'] = 6,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    }
                },
                onEquip = function()  
                end
            },
            [2] = {
                label = "Tenue Officier",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                        ['torso_1'] = 55, ['torso_2'] = 0,
                        ['arms'] = 30,
                        ['pants_1'] = 35, ['pants_2'] = 0,
                        ['shoes_1'] =24, ['shoes_2'] = 0,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    },
                    female = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 15,['tshirt_2'] = 2,
                        ['torso_1'] = 65, ['torso_2'] = 2,
                        ['arms'] = 36, ['arms_2'] = 0,
                        ['pants_1'] = 38, ['pants_2'] = 2,
                        ['shoes_1'] = 12, ['shoes_2'] = 6,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    }
                },
                onEquip = function()  
                end
            },
            [3] = {
                label = "Tenue Marie",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                        ['torso_1'] = 55, ['torso_2'] = 0,
                        ['arms'] = 30,
                        ['pants_1'] = 35, ['pants_2'] = 0,
                        ['shoes_1'] =24, ['shoes_2'] = 0,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    },
                    female = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 15,['tshirt_2'] = 2,
                        ['torso_1'] = 65, ['torso_2'] = 2,
                        ['arms'] = 36, ['arms_2'] = 0,
                        ['pants_1'] = 38, ['pants_2'] = 2,
                        ['shoes_1'] = 12, ['shoes_2'] = 6,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    }
                },
                onEquip = function()  
                end
            },
            [4] = {
                label = "Tenue Sergent",
                minimum_grade = 2, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                        ['torso_1'] = 55, ['torso_2'] = 0,
                        ['arms'] = 30,
                        ['pants_1'] = 35, ['pants_2'] = 0,
                        ['shoes_1'] =24, ['shoes_2'] = 0,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0, ['bproof_2'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    },
                    female = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 15,['tshirt_2'] = 2,
                        ['torso_1'] = 65, ['torso_2'] = 2,
                        ['arms'] = 36, ['arms_2'] = 0,
                        ['pants_1'] = 38, ['pants_2'] = 2,
                        ['shoes_1'] = 12, ['shoes_2'] = 6,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    }
                },
                onEquip = function()  
                end
            },
            [5] = {
                label = "Tenue Lieutenant",
                minimum_grade = 3, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                        ['torso_1'] = 55, ['torso_2'] = 0,
                        ['arms'] = 30,
                        ['pants_1'] = 35, ['pants_2'] = 0,
                        ['shoes_1'] =24, ['shoes_2'] = 0,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0, ['bproof_2'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    },
                    female = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 15,['tshirt_2'] = 2,
                        ['torso_1'] = 65, ['torso_2'] = 2,
                        ['arms'] = 36, ['arms_2'] = 0,
                        ['pants_1'] = 38, ['pants_2'] = 2,
                        ['shoes_1'] = 12, ['shoes_2'] = 6,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    }
                },
                onEquip = function()  
                end
            },
            [6] = {
                label = "Tenue Henri",
                minimum_grade = 3, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                        ['torso_1'] = 55, ['torso_2'] = 0,
                        ['arms'] = 30,
                        ['pants_1'] = 35, ['pants_2'] = 0,
                        ['shoes_1'] =24, ['shoes_2'] = 0,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0, ['bproof_2'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    },
                    female = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 15,['tshirt_2'] = 2,
                        ['torso_1'] = 65, ['torso_2'] = 2,
                        ['arms'] = 36, ['arms_2'] = 0,
                        ['pants_1'] = 38, ['pants_2'] = 2,
                        ['shoes_1'] = 12, ['shoes_2'] = 6,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    }
                },
                onEquip = function()  
                end
            },
            [7] = {
                label = "Tenue Hubert",
                minimum_grade = 3, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                        ['torso_1'] = 55, ['torso_2'] = 0,
                        ['arms'] = 30,
                        ['pants_1'] = 35, ['pants_2'] = 0,
                        ['shoes_1'] =24, ['shoes_2'] = 0,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0, ['bproof_2'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    },
                    female = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 15,['tshirt_2'] = 2,
                        ['torso_1'] = 65, ['torso_2'] = 2,
                        ['arms'] = 36, ['arms_2'] = 0,
                        ['pants_1'] = 38, ['pants_2'] = 2,
                        ['shoes_1'] = 12, ['shoes_2'] = 6,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    }
                },
                onEquip = function()  
                end
            },
            [8] = {
                label = "Tenue Capitaine",
                minimum_grade = 4, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                        ['torso_1'] = 55, ['torso_2'] = 0,
                        ['arms'] = 30,
                        ['pants_1'] = 35, ['pants_2'] = 0,
                        ['shoes_1'] =24, ['shoes_2'] = 0,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0, ['bproof_2'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    },
                    female = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 15,['tshirt_2'] = 2,
                        ['torso_1'] = 65, ['torso_2'] = 2,
                        ['arms'] = 36, ['arms_2'] = 0,
                        ['pants_1'] = 38, ['pants_2'] = 2,
                        ['shoes_1'] = 12, ['shoes_2'] = 6,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    }
                },
                onEquip = function()  
                end
            },
            [9] = {
                label = "Tenue Commandant",
                minimum_grade = 5, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                        ['torso_1'] = 55, ['torso_2'] = 0,
                        ['arms'] = 30,
                        ['pants_1'] = 35, ['pants_2'] = 0,
                        ['shoes_1'] =24, ['shoes_2'] = 0,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0, ['bproof_2'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    },
                    female = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 15,['tshirt_2'] = 2,
                        ['torso_1'] = 65, ['torso_2'] = 2,
                        ['arms'] = 36, ['arms_2'] = 0,
                        ['pants_1'] = 38, ['pants_2'] = 2,
                        ['shoes_1'] = 12, ['shoes_2'] = 6,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                    }
                },
                onEquip = function()  
                end
            }
        },
        grades = {
            [0] = {
                label = "Mettre",
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {
                male = {
                    ['bproof_1'] = 10, ['bproof_2'] = 1,
                },
                female = {
                    ['bproof_1'] = 10, ['bproof_2'] = 1,
                }
            },
            onEquip = function()
            end
        },
		[1] = {
			label = "Enlever",
			minimum_grade = 0, -- grade minmum pour prendre la tenue
			variations = {
			male = {
				['bproof_1'] = 0,
			},
			female = {
				['bproof_1'] = 0,
			}
		},
		onEquip = function()
            SetPedArmour(PlayerPedId(), 0)
		end
	},
    }
},
	vehicles = {                                                         -- category = Separator en rageui 
        car = {                                                           -- Label = nom ig qui apparaitra sur le bouton 
            {category = "↓ ~b~Véhicules ~s~↓"},                           -- Model = nom de spawn du véhicule
            {model = "police", label = "Victoria", minimum_grade = 0}, --minimum_grade = grade minmum pour prendre
			{model = "scoutpol", label = "Pscout", minimum_grade = 1},
            {model = "police22", label = "Bravado", minimum_grade = 3},
            {model = "intcept", label = "Interceptor", minimum_grade = 4},
            {model = "wmfenyrcop", label = "Véhicule d'intervention Rapide", minimum_grade = 4},
        },
    }

    
}
