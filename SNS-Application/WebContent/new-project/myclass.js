"use strict";

const white_bg = "#ebebeb";
const white_out = "3px 3px 8px #d4d4d4, -3px -3px 8px #ffffff";
const white_in = "inset 3px 3px 8px #d4d4d4, inset -3px -3px 8px #ffffff";
/**               method              */
function getId(data) {
    var elm = document.getElementById(data);
    return elm;
}

function iconClick(e) {

    deleteDisplay();

    for(let i=0; i<$icon.length; i++){
        $icon[i].style.boxShadow = white_out;
        //$icon[i].style.background = "linear-gradient(145deg, #ffe0d8, #ddbcb6)";
    }
    getId(e.target.id).style.boxShadow = white_in;
    //getId(e.target.id).style.background = "linear-gradient(145deg, #ddbcb6, #ffe0d8)";

    switch (e.target.id) {
        case "home-icon":
            $Home.style.display = "block";
            break;
        case "repentance-icon":
            $Repentance.style.display = "block";
            break;
        case "friends-icon":
            $Friends.style.display = "block";
            break;
        case "addThread":
            getId("addThread-display").style.display = "block";
        default:
            break;
    }
}
let selectThreadCount = 0;
function selectThreadFunc(){
    if(selectThreadCount == 0){
        getId("home-contents").style.display = "none";
        getId("addThread-display").style.display = "none";
        getId("openThread-contents").style.display = "none";
        getId("selectThread-contents").style.display = "block";
        getId("select-home-btn").style.boxShadow = "inset 2.5px 2.5px 5px 0 #cacbce, inset -2px -2px 5px #ffffff";
        selectThreadCount = 1;
    }else if(selectThreadCount == 1){
        getId("home-contents").style.display = "block";
        getId("addThread-display").style.display = "none";
        getId("selectThread-contents").style.display = "none";
        getId("openThread-contents").style.display = "none";
        getId("select-home-btn").style.boxShadow = "-2px -2px 5px rgba(255, 255, 255, 1), 2.5px 2.5px 5px rgba(0, 0, 0, 0.1)";
        selectThreadCount = 0;
    }

}

function openThreadFunc(){
    getId("home-contents").style.display = "none";
    getId("addThread-display").style.display = "none";
    getId("selectThread-contents").style.display = "none";
    getId("openThread-contents").style.display = "block";
}

const open_form_count = 0;
const close_form_count = 1;
let message_form_count = open_form_count;
const $friends_list = document.getElementsByClassName("friends-list");
function message_form_func(){

    if(message_form_count == open_form_count){
        getId("friends-message-form").style.display = "block";

        for(let i=0; i<$friends_list.length; i++){
            $friends_list[i].style.display = "none";
        }
        message_form_count = close_form_count;
    }
    else if(message_form_count == close_form_count){
        getId("friends-message-form").style.display = "none";

        for(let i=0; i<$friends_list.length; i++){
            $friends_list[i].style.display = "block";
            $friends_list[i].style.display = "flex";
        }
        message_form_count = open_form_count;
    }
}

let friends_profile_count = open_form_count;
function friends_profile_func(){

    if(friends_profile_count == open_form_count){
        getId("friends-profile").style.display = "block";
        for(let i=0; i<$friends_list.length; i++){
            $friends_list[i].style.display = "none";
        }
        friends_profile_count = close_form_count;
    }
    else if(friends_profile_count == close_form_count){
        getId("friends-profile").style.display = "none";
        for(let i=0; i<$friends_list.length; i++){
            $friends_list[i].style.display = "block";
            $friends_list[i].style.display = "flex";
        }
        friends_profile_count = open_form_count;
    }
}

function EntryBtnClick(e){
    deleteBeforeEntry();
    switch (e.target.id) {
        case "signinBtn":
            getId("Loginform").style.display = "block";
            break;
        case "signupBtn":
            getId("Entryform").style.display = "block";
            break;
        default:
            console.log("Error");
            break;
    }
}

function FormExit() {
    deleteEntryform();
    deleteLoginform();
    getId("BeforeEntry").style.display = "block";
}

let threadCount = 0;
function addThreadFunc() {//profileで使う
    if(threadCount == 0){
        getId("home-contents").style.display = "none";
        getId("addThread-display").style.display = "block";
        getId("selectThread-contents").style.display = "none";
        getId("openThread-contents").style.display = "none";
        getId("addThread").textContent = "return"
        getId("addThread").style.boxShadow = "2px 2px 5px #d0b2ac inset, 4px 4px 6px  #fff0e8";
        threadCount = 1;
    }else if(threadCount == 1){
        getId("home-contents").style.display = "block";
        getId("addThread-display").style.display = "none";
        getId("home-contents").style.display = "flex";
        getId("addThread").textContent = "add"
        getId("addThread").style.boxShadow = "-2px -2px 5px #fff0e8, 2px 2px 5px #d0b2ac";
        threadCount = 0;
    }
}

function deleteDisplay() {
    $Home.style.display = "none";
    $Repentance.style.display = "none";
    $Friends.style.display = "none";
    getId("addThread-display").style.display = "none";
}
function deleteBeforeEntry() {
    getId("BeforeEntry").style.display = "none";
}
function deleteEntryform() {
    $Entryform.style.display = "none";
}
function deleteLoginform() {
    $Loginform.style.display = "none";
}
/**                   main                    */
const $icon = document.getElementsByClassName("icon");
const $Home = getId("home-display");
const $Repentance = getId("repentance-display");
const $Friends = getId("friends-display");
for (var i = 0; i < $icon.length; i++) {
    $icon[i].addEventListener("click", function(e){
        iconClick(e);
    });
}

const $EntryBtn = document.getElementsByClassName("entryBtn");
const $Entryform = getId("Entryform");
const $Loginform = getId("Loginform");
for(let i=0; i<$EntryBtn.length; i++){
    $EntryBtn[i].addEventListener("click", function(e){
        EntryBtnClick(e);
    });
}










