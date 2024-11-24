fx_version 'cerulean'
games { 'rdr3' }

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Suu Yoshida'
description 'Discord-based dynamic radial menu addon system for RSG Framework'
version '1.0.0'

shared_script 'config.lua'
server_script 'server/main.lua'
client_script 'client/main.lua'

dependencies {
    'rsg-radialmenu',
    'rsg-core'
}

lua54 'yes'