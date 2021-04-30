<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<%@ page import="user.UserData" %>
<%@ page import="collection.CreateList" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Optional" %>
<%
request.setCharacterEncoding("UTF-8");

System.out.println("------------Start JSP-------------");
// 新規登録後のHomeHeader
// 新規登録後のスレッド
// servlet遷移のURLを登録
// 友達のアカウントクリックでプロフィール表示、スレッドの表示

//-------------------------------USER_DATA-------------------------------------
UserData userdata = (UserData)session.getAttribute("user_data");
Optional<String> userName = Optional.ofNullable("");
if(userdata != null){
	userName = Optional.ofNullable(userdata.getName());
}

//--------------------------------isEnter--------------------------------------
Optional<Boolean> isEnter = Optional.ofNullable((Boolean)session.getAttribute("isEnter"));

System.out.println("isEnter: " + isEnter);

//----------------------isAfterLogin & isAfterEntry----------------------------
Optional<Boolean> isAfterEntry = Optional.ofNullable((Boolean)request.getAttribute("AFTER_ENTRY"));
Optional<Boolean> isAfterLogin = Optional.ofNullable((Boolean)request.getAttribute("AFTER_LOGIN"));

System.out.println("isAfterEntry: " + isAfterEntry);
System.out.println("isAfterLogin: " + isAfterLogin);

//-----------------------------isLoginResult-------------------------------------
final String IS_NOT_NAME = "false name";
final String IS_NOT_PASSWORD = "false password";
final String IS_ALLOWED_LOGIN = "true";
final String LOGIN_IS_NULL = "null";

Optional<String> LoginResult = Optional.ofNullable((String)request.getAttribute("LoginResult"));

System.out.println("LoginResult: " + LoginResult);

//---------------------------EntryName_isNotExists------------------------------------
Optional<Boolean> EntryName_isNotExists = Optional.ofNullable((Boolean)request.getAttribute("Entry_isNotExist"));
Optional<String> EntryName = Optional.ofNullable((String)request.getAttribute("EntryName"));

System.out.println("EntryName_isNotExist: " + EntryName_isNotExists);

//---------------------------------------Message-------------------------------------------
Optional<Boolean> isDisplayMessage = Optional.ofNullable((Boolean)request.getAttribute("isDisplayMessage"));
Optional<Boolean> isDisplayOpenedMessage = Optional.ofNullable((Boolean)request.getAttribute("isDisplayOpenedMessage"));
System.out.println("isDisplayMessage: " + isDisplayMessage);
System.out.println("isDisplayOpenedMessage: " + isDisplayOpenedMessage);
int message_ary = 0;

CreateList MessageList;
LinkedList<String> Message_TitleList = new LinkedList<String>();
LinkedList<String> Message_CommentsList = new LinkedList<String>();
LinkedList<String> Message_FromUserList = new LinkedList<String>();
LinkedList<String> Message_ToUserList = new LinkedList<String>();
LinkedList<String> Message_DateList = new LinkedList<String>();
if(isEnter.orElse(false)){
	MessageList = new CreateList(CreateList.getMessageSQL(), new LinkedList<String>(Arrays.asList(userdata.getName())));
	Message_TitleList = MessageList.setList(new LinkedList<String>(), "title");
	Message_CommentsList = MessageList.setList(new LinkedList<String>(), "comments");
	Message_FromUserList = MessageList.setList(new LinkedList<String>(), "from_user");
	Message_ToUserList = MessageList.setList(new LinkedList<String>(), "to_user");
	Message_DateList = MessageList.setList(new LinkedList<String>(), "date");
	if(Message_TitleList.size() == 0){
		Message_TitleList.add("HELLO " + userdata.getName());
		Message_CommentsList.add("Follow fiends");
		Message_FromUserList.add("SNS");
		Message_ToUserList.add(userdata.getName());
	}
}
else{
	Message_TitleList.add("HELLO");
	Message_CommentsList.add("You should signin to use Message-Form, Friends-form");
	Message_FromUserList.add("SNS");
	Message_ToUserList.add("User");
}
if(isDisplayOpenedMessage.orElse(false)){
	String click_ary_str = (String)request.getAttribute("message_ary");
	message_ary = Integer.parseInt(click_ary_str);
}

//--------------------------------------Friends---------------------------------------------
Optional<Boolean> isDisplayFriends = Optional.ofNullable((Boolean)request.getAttribute("isDisplayFriends"));
Optional<Boolean> isDisplayFriendsProfile = Optional.ofNullable((Boolean)request.getAttribute("isDisplayFriendsProfile"));

Optional<String> friends_name = Optional.ofNullable((String)request.getAttribute("friends_name"));
Optional<String> friends_gender = Optional.ofNullable((String)request.getAttribute("friends_gender"));
Optional<String> friends_age = Optional.ofNullable((String)request.getAttribute("friends_age"));
Optional<String> friends_music_type = Optional.ofNullable((String)request.getAttribute("friends_music_type"));
Optional<String> friends_instrument = Optional.ofNullable((String)request.getAttribute("friends_instrument"));
Optional<String> friends_favorite_musician = Optional.ofNullable((String)request.getAttribute("friends_favorite_musician"));

CreateList FriendsList;
LinkedList<String> Friends_NameList = new LinkedList<String>();
if(isEnter.orElse(false)){
    FriendsList = new CreateList(CreateList.getFriendsSQL(), new LinkedList<String>(Arrays.asList(userdata.getName())));
    Friends_NameList = FriendsList.setList(new LinkedList<String>(), "friends_name");
    for(int i=0; i<Friends_NameList.size(); i++){
    	System.out.println("Friends_NameList: " + Friends_NameList.get(i));
    }
    if(Friends_NameList.size() == 0){
    	Friends_NameList.add("Follow someone!");
    }
}
else{
	Friends_NameList.add("Should you SIGNUP or SIGNIN");
}

System.out.println("isDisplayFriends: " + isDisplayFriends);
System.out.println("isDisplayFriendsProfile: " + isDisplayFriendsProfile);
System.out.println("Friends_name : " + friends_name.orElse(""));
System.out.println("Friends_gender : " + friends_gender.orElse(""));
System.out.println("Friends_age : " + friends_age.orElse(""));

//-----------------------------------Thread-------------------------------------------
Optional<Boolean> isDisplayHome = Optional.ofNullable((Boolean)request.getAttribute("isDisplayHome"));
Optional<Boolean> isDisplayThread = Optional.ofNullable((Boolean)request.getAttribute("isDisplayThread"));
Optional<Boolean> firstDisplay = Optional.ofNullable((Boolean)session.getAttribute("firstDisplay"));
int click_ary = 0;

if(firstDisplay.orElse(true) || isAfterEntry.orElse(false) || isAfterLogin.orElse(false)){
	isDisplayHome = Optional.ofNullable(true);
	session.setAttribute("type", "classic");
	session.setAttribute("kind", "trend");
	session.setAttribute("firstDisplay", false);
}
if(!isDisplayFriends.orElse(false) && !isDisplayMessage.orElse(false)){
	isDisplayHome = Optional.ofNullable(true);
}

Optional<String> type = Optional.ofNullable((String)session.getAttribute("type"));
Optional<String> kind = Optional.ofNullable((String)session.getAttribute("kind"));
System.out.println("isDisplayHome: " + isDisplayHome);
System.out.println("isDisplayThread: " + isDisplayThread);
System.out.println("type, kind: " + type.orElse("") + "," + kind.orElse(""));

CreateList ThreadList = new CreateList(CreateList.getThreadSQL(), new LinkedList<String>(Arrays.asList(type.orElse(""), kind.orElse(""))));
LinkedList<String> Thread_TitleList = ThreadList.setList(new LinkedList<String>(), "title" );
LinkedList<String> Thread_ContentsList = ThreadList.setList(new LinkedList<String>(), "comment" );
LinkedList<String> Thread_DateList = ThreadList.setList(new LinkedList<String>(), "date" );
LinkedList<String> Thread_NameList = ThreadList.setList(new LinkedList<String>(), "name" );
if(isDisplayThread.orElse(false)){
	String click_ary_str = (String)request.getAttribute("click_ary");
	click_ary = Integer.parseInt(click_ary_str);
}
System.out.println("click_ary: " + click_ary);
System.out.println("Thread_NameList.size(): " + Thread_NameList.size());

//----------------------------------isSelectedContentsLinked-------------------------------------
Optional<Boolean> isDisplayBell = Optional.ofNullable((Boolean)request.getAttribute("isDisplayBell"));
int bell_ary_int = 0;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
<link rel="stylesheet" href="main.css">
<title>Insert title here</title>
</head>
<body>
<div id="left-body">

    <div id="select-icon">
        <div id="home-icon" class="icon"
        <%if(isDisplayHome.orElse(false)){%>
            style="box-shadow: inset 2px 2px 4px 0 #cacbce, inset -2px -2px 4px #ffffff"
        <%}%>
        ><i class="fa fa-home" aria-hidden="true"></i></div>
        <div id="repentance-icon" class="icon"
        <%if(isDisplayMessage.orElse(false)){%>
            style="box-shadow: inset 2px 2px 4px 0 #cacbce, inset -2px -2px 4px #ffffff"
        <%}%>><i class="fa fa-envelope" aria-hidden="true"></i></div>
        <div id="friends-icon" class="icon"
        <%if(isDisplayFriends.orElse(false)){%>
            style="box-shadow: inset 2px 2px 4px 0 #cacbce, inset -2px -2px 4px #ffffff"
        <%}%>><i class="fa fa-user-friends" aria-hidden="true"></i></div>
        <div id="addThread" class="icon"
        <%if(!isEnter.orElse(false)){ %>
            style="display: none"
        <%} %>><i class="fa fa-comment-alt" aria-hidden="true"></i></div>
    </div>
<!--                     HOME                          -->
    <div id="home-display" class="main"
    <%if(isDisplayHome.orElse(false)){%>
        style="display: block"
    <%}else{ %>
        style="display: none"
    <%} %>
    >
        <div id="home-header" class="main-header">
            <div id="home-title">
                 <%if(isDisplayHome.orElse(false)){ %>
                         <p><%=type.orElse("") %> <%=kind.orElse("") %></p>
                    <%}else{ %>
                        <p>classical music</p>
                    <%} %>

            </div>

            <div id="select-home-btn" class="home-btn" onclick="selectThreadFunc()"><i class="fa fa-redo" aria-hidden="true"></i></div>

        </div>
        <!--              THREAD                -->
        <div id="home-contents" class="main-contents"
        <%if(isDisplayThread.orElse(false)){%>
            style="display: none"
        <%}else{%>
            style="display: block"
        <%} %>
         >

           <%for(int i=0; i<Thread_TitleList.size(); i++){%>
               <%String num = "" + i; %>
               <form class="thread" action="http://localhost:5865/EveryChat/Thread" method="get">
        	       <input id="threadSubmit"  type="submit" value="">
        	       <input type="hidden" name="ThreadControllerGet" value="OpenThread">
        	       <input type="hidden" name="click_ary" value=<%=num %>>
        	       <div class="threadTitle"><%=Thread_TitleList.get(i) %></div>
        	       <div class="threadName"><%=Thread_NameList.get(i) %></div>
                   <div  class="threadDate"><%=Thread_DateList.get(i) %></div>
               </form>
           <% }%>

        </div>
        <!--             OPEN THREAD             -->
        <div id="openThread-contents" class="main-contents"
        <%if(isDisplayThread.orElse(false)){ %>
            style="display: block"
        <%} %>
         >
         <%if(isDisplayThread.orElse(false)) {%>
            <form id="exit_open_thread" action="http://localhost:5865/EveryChat/Thread" method="get">
                <input id="exit_open_thread_submit" type="submit" value="×">
                <input type="hidden" name="ThreadControllerGet" value="exit">
            </form>

            <div id="openThread-title">
                <p><%=Thread_TitleList.get(click_ary) %></p>
            </div>
            <div id="openThread-comment">
                <p id="openThread-comment-p"><%=Thread_ContentsList.get(click_ary) %></p>
                <p id="openThread-comment-name"><%=Thread_NameList.get(click_ary)%></p>
            </div>

            <form id="friend_request_form" action="http://localhost:5865/EveryChat/Thread" method="get"
                <%if(Friends_NameList.contains(Thread_NameList.get(click_ary)) || Thread_NameList.get(click_ary).equals(userName.orElse("")) || !isEnter.orElse(false))
                    { %>style="display: none"<%} %>>
                <input type="submit" value="Follw">
                <input type="hidden" name="ThreadControllerGet" value="Friends">
                <input type="hidden" name="friends_request_name" value=<%=Thread_NameList.get(click_ary) %>>
            </form>
        <%} %>
        </div>
        <!--            SELECT THREAD            -->
        <div id="selectThread-contents" class="main-contents" style="display: none">
            <form id="selectThread-form" action="http://localhost:5865/EveryChat/Thread" method="get">
                <div id="select-type-title" class="radio-title">
                    <p id="select-type" class="select-thread-title">music type</p>
                </div>
                <div id="select-type-radio" class="select-radio">
                    <input id="classic" class="select-type" type="radio" name="select-type" value="classic">
                    <label for="classic">Classic</label>
                    <input id="pops" class="select-type" type="radio" name="select-type" value="pops">
                    <label for="pops">Pops</label>
                    <input id="jazz" class="select-type" type="radio" name="select-type" value="jazz">
                    <label for="jazz">Jazz</label>
                </div>
                <div id="select-option-title" class="radio-title">
                <p id="select-option" class="select-thread-title">option</p>
                </div>
                <div id="select-option-radio" class="select-radio">
                    <input id="trend" class="select-option" type="radio" name="select-option" value="trend">
                    <label for="trend">Trend</label>
                    <input id="analyze" class="select-option" type="radio" name="select-option" value="analyze">
                    <label for="analyze">Analyze</label>
                    <input id="talk" class="select-option" type="radio" name="select-option" value="talk">
                    <label for="talk">Talk</label>
                </div>
                <input type="hidden" name="ThreadControllerGet" value="select">
                <input id="selectThreadBtn" type="submit" name="selectThreadBtn" value="change">
            </form>
        </div>
    </div>
<!--                     Message                      -->
    <div id="repentance-display" class="main"
    <%if(isDisplayMessage.orElse(false)){%>
        style="display: block"
    <%}else{ %>
        style="display: none"
    <%} %>
    >
        <div id="repentance-header" class="main-header">
            <div id="bell-title">
                <p class="title">Message</p>
            </div>
        </div>
        <div id="repentance-contents">

        <%if(!isDisplayOpenedMessage.orElse(false)) {%>

                <%for(int i=0; i < Message_TitleList.size(); i++){ %>
                    <div class="bell">
                        <form class="bell-open-icon" action="http://localhost:5865/EveryChat/MessageController" method="get">
                            <div>
                                <input id="open_message" class="bell-open-icon-submit" type="submit" name="open_bell_message" value="">
                                <i class="far fa-comment-dots" aria-hidden="true" style="transform: scale(-1, 1)"></i>
                            </div>
                            <input type="hidden" name="message_ary" value=<%=i %>>
                            <input type="hidden" name="MessageGet" value="open">
                        </form>
                        <div class="bell-title">
                            <%=Message_TitleList.get(i)%>
                        </div>
                    </div>
                <% }%>
          <%} %>


       <%if(isDisplayOpenedMessage.orElse(false)) {
    	   String fromName = Message_FromUserList.get(message_ary);%>
           <div id="open-bell">
               <form action="http://localhost:5865/EveryChat/MessageController" method="get">
                   <input id="return_reply" type="submit" name="return_reply_message" value="×">
                   <input type="hidden" name="MessageGet" value="exit">
               </form>
               <div id="open-bell-title">
                   <%=Message_TitleList.get(message_ary) %>
               </div>
               <div id="open-bell-textarea">
                   <p id="open_bell_for_name">Dear <%=Message_ToUserList.get(message_ary) %></p>
                   <p id="open_bell_comments"><%=Message_CommentsList.get(message_ary) %></p>
               </div>
               <p id="open_bell_from_name"><%=fromName %></p>

               <div id="open-bell-follow"
                   <%if(Friends_NameList.contains(fromName) || fromName.equals(userName.orElse("")) || !isEnter.orElse(false)) {%>
                       style="display: none"
                   <%} %>>Follow</div>
           </div>
       <%} %>
       </div>

        <div id="repentance-footer" class="main-footer">
        </div>
    </div>
<!--                     FRIEND                          -->
    <div id="friends-display" class="main"
        <%if(!isDisplayFriends.orElse(false)) {%>
            style="display:none"
        <%} %>>
        <div id="friends-header">
            <div id="friends-title">
                <p class="title">Friends</p>
            </div>
            <form id="friends-form" action="" method="get">
                <input class="search" type="text" name="friendSearch">
                <input class="button" type="submit" name="friendBtn" value="検索">
            </form>
        </div>

        <div id="friends-contents">

            <%for(int i=0; i < Friends_NameList.size(); i++){ %>
                <div class="friends-list"
                    <%if(isDisplayFriendsProfile.orElse(false)) {%>
                        style="display: none"
                    <%} %>
                >
                    <div class="friends-name">
                        <%=Friends_NameList.get(i) %>
                    </div>
                    <div class="friends-form">
                        <form class="friends-thread" action="http://localhost:5865/EveryChat/FriendsController" method="get">
                            <input type="submit" name="open" value="">
                            <input type="hidden" name="FriendsController" value="open">
                            <input type="hidden" name="friends_name" value=<%=Friends_NameList.get(i) %>>
                            <i class="fas fa-user-circle"></i>
                        </form>
                        <div class="friends-message"<%if(isEnter.orElse(false)){ %>onclick="message_form_func()" <%} %>><i class="far fa-paper-plane"></i></div>
                    </div>
                </div>
            <%} %>

            <form id="friends-message-form" action="http://localhost:5865/EveryChat/FriendsController" method="post" style="display:none">
                <div id="exit-friends-message-form" onclick="message_form_func()"><p>×</p></div>
                <input id="friends-message-title" type="text" name="friends-message-title">
                <textarea id="friends-message-comments" name="friends-message-comments" rows="5" cols="40" style="overflow:hidden"></textarea>
                <input id="friends-message-submit" type="submit" name="friends-message-submit" value="send">
                <input type="hidden" name="send_message_name"
                    <%if(isEnter.orElse(false)){ %>
                        value=<%= isEnter%>
                    <%}%>
                        >
            </form>
            <div id="friends-profile"
                <%if(!isDisplayFriendsProfile.orElse(false)){ %>
                     style="display: none"
                <%} %>
            >
                <form id="friends-exit" action="http://localhost:5865/EveryChat/FriendsController" method="get">
                    <input type="submit" value="×">
                    <input type="hidden" name="FriendsController" value="close">
                </form>
                <div id="friends-profile-name"><%=friends_name.orElse("") %></div>
                <div id="friends-profile-contents">
                    <div id="friends-profile-data">
                        <p>gender : <%=friends_gender.orElse("") %></p>
                        <p>age : <%=friends_age.orElse("") %></p>
                        <p>music type : <%=friends_music_type.orElse("") %></p>
                        <p>instrument : <%=friends_instrument.orElse("") %></p>
                        <p>favorite musician : <%=friends_favorite_musician.orElse("") %></p>
                    </div>

                </div>
                <div id="friends-profile-open">open threads</div>
            </div>

        </div>


    </div>
    <!--                  ADD THREAD            -->
    <div id="addThread-display" class="main" style="display: none">
        <div id="addThread-header" class="main-header"></div>
        <div id="addThread-contents" class="main-contents" >
            <form id="thread-form" action="http://localhost:5865/EveryChat/Thread" method="post">
                <p id="thread-title-p">Title</p>
                <input id="thread-title" type="text" name="threadTitle">
                <p id="thread-comment-p">Comments</p>
                <textarea id="thread-comment" name="threadComments" rows="5" cols="40" style="overflow:hidden"></textarea>

                <div id="addType" class="addRadio">
                    <input id="add-classic" type="radio" name="addType" value="classic">
                    <label for="add-classic">Classic</label>
                    <input id="add-pops" type="radio" name="addType" value="pops">
                    <label for="add-pops">Pops</label>
                    <input id="add-jazz" type="radio" name="addType" value="jazz">
                    <label for="add-jazz">Jazz</label>
                </div>
                <div id="addOption" class="addRadio">
                    <input id="add-trend" type="radio" name="addOption" value="trend">
                    <label for="add-trend">Trend</label>
                    <input id="add-analyze" type="radio" name="addOption" value="analyze">
                    <label for="add-analyze">Analyze</label>
                    <input id="add-talk" type="radio" name="addOption" value="talk">
                    <label for="add-talk">Talk</label>
                </div>
                <input id="addThreadBtn" type="submit" name="addThreadBtn" value="Add Thread">
            </form>
        </div>
    </div>


</div>

<!--                      RIGHT BODY                     -->

<!--                  AFTER ENTRY DISPLAY                    -->
<div id="AfterEntry" class="right-body"
<%if(!isEnter.orElse(false)){ %>
   style="display: none"
<%} %>>

    <div id="user-stutas">
    <%if(isEnter.orElse(false)){ %>
        <p id="user-name"><%=userdata.getName() %></p>
        <p id="user-gender">gender: <%=userdata.getGender() %></p>
        <p id="user-age">age: <%=userdata.getAge() %></p>
        <p id="favorite-music" class="stutas-favorite">music: <%=userdata.getMusicType() %></p>
        <p id="favorite-instrument" class="stutas-favorite">instrument: <%=userdata.getInstrument() %></p>
        <p id="favorite-musician" class="stutas-favorite">favorite musician:<%=userdata.getFavoriteMusician() %></p>
    <%} %>
    </div>
    <div id="addThread" >add</div>
</div>

<!--                  BEFORE ENTRY DISPLAY                      -->
<div id="BeforeEntry" class="right-body"
    <%if(isEnter.orElse(false)){ %>
        style="display: none"
    <%}else if(isAfterLogin.orElse(false)){ %>
         style="display: none"
    <%}else if(isAfterEntry.orElse(false)){ %>
         style="display: none"
    <%} %>
>
    <div id="signinBtn" class="entryBtn"><p>signIn</p></div>
    <div id="signupBtn" class="entryBtn"><p>signUp</p></div>

</div>

<!--                      ENTRY FORM                        -->
<div id="Entryform" class="right-body"
    <%if(!isAfterEntry.orElse(false) || isEnter.orElse(false)){ %>
         style="display: none"
    <%} %>
    >
    <form id="entry-form" action="http://localhost:5865/EveryChat/Login" method="post" style="display: block">
        <div id="EntryformExit" style="display: inline-block" onclick="FormExit()"><p>×</p></div>
        <p id="entry-form-title">Entryform</p>

        <div id="first-entry-form" class="entry-form-box"
            <%if((EntryName_isNotExists.orElse(false) && isAfterEntry.orElse(false)) || isEnter.orElse(false)) {%>
                style="display: none"
            <%} %>>
            <p id="account-name-p">name (3 ~ 8)</p>
            <input type="text" name="first_EntryName" id="account-name">
            <p id="account-name-attention"
                <%if(EntryName_isNotExists.orElse(false) || !isAfterEntry.orElse(false)){ %>
                    style="visibility: hidden"
                <%}%>>Name is exist</p>
            <input type="submit" name="entry-btn" id="Entryform-submit" value="check" >
        </div>

        <div id="seccond-entry-form" class="entry-form-box"
            <%if(!EntryName_isNotExists.orElse(false)){ %>
                    style="display: none"
            <%}%>>
            <div id="seccond-entry-title"><%=EntryName.orElse("") %></div>
            <input type="hidden" name="seccond_EntryName" value=<%=EntryName.orElse("") %>>

            <div id="entry-gender"><label id="entry-gender-p">Gender :</label>
                <label class="entry-gender-radio">
                    man
                    <input type="radio" name="entry-gender" value="man">
                </label>
                <label class="entry-gender-radio">
                    woman
                    <input type="radio" name="entry-gender" value="woman">
                </label>
            </div>
            <div id="entry-age">Age :
                <select id="entry-age-select" name="entry_age">
                    <%for(int i=12; i<80; i++){ %>
                        <option value=<%=i %>><%=i %></option>
                    <%} %>
                </select>
            </div>
            <div id="entry-music-type-p"><p>Music Type</p></div>
            <div id="entry-music-type-box">
                <label>
                    <input class="entry-music-type" type="radio" name="music-type" value="classic">
                    Classic
                </label>
                <label>
                    <input class="entry-music-type" type="radio" name="music-type" value="pops">
                    Pops
                </label>
                <label>
                    <input class="entry-music-type" type="radio" name="music-type" value="jazz">
                    Jazz
                </label>
            </div>
            <div id="entry-instrument-p">Instrument</div>
            <input id="entry-instrument" type="text" name="entry-instrument">
            <div id="entry-favorite-musician-p">Favorite Musician</div>
            <input id="entry-favorite-musician" type="text" name="entry-favorite-musician">
            <div id="entry-password-p">Password</div>
            <input id="entry-password" type="password" name="entry-password">
            <input id="entry-seccond-submit" type="submit" name="entry-btn" value="ENTRY">
        </div>

    </form>
</div>
<!--                       LOGIN FORM                         -->
<div id="Loginform" class="right-body"
<%if(!isAfterLogin.orElse(false) || isEnter.orElse(false)){ %>
    style="display: none"
<%}%>
>
    <div id="EntryformExit" style="display: inline-block" onclick="FormExit()"><p>×</p></div>
    <p id="loginform-title">Loginform</p>
    <form id="account-form" action="http://localhost:5865/EveryChat/Login" method="get">
        <p id="account-name-p">name</p>
        <input type="text" name="account-name" id="account-name">
        <p id="account-password-p">password</p>
        <input type="password" name="account-password" id="account-password">

            <%switch(LoginResult.orElse("IS_NULL")){
                case IS_NOT_NAME: %>
                	<p id="LoginFalse">couldn't find name</p>
                	<%break;
                case IS_NOT_PASSWORD:%>
                    <p id="LoginFalse">password is false</p>
                    <%break;
            } %>

        <input type="submit" name="account-login-btn" id="Loginform-submit" value="Login">
    </form>
</div>
<script src="new-project/myclass.js" type="text/javascript"></script>
</body>
</html>








