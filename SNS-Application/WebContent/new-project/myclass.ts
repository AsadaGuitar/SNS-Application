const $icon = document.getElementsByClassName("icon");

function getId(data: string){
	let elm: HTMLInputElement = <HTMLInputElement>document.getElementById(data);
	return elm;
}

function iconClick(e: any){
	deleteDisplay();
	switch (e.id) {
		case "home-icon":
			$Home.style.display = "block";
			console.log("good");
			break;
		case "repentance-icon":
			$Repentance.style.display = "block";
			break;
		case "friends-icon":
			$Friends.style.display = "block";
			break;
		default:
			console.log("error");
			break;
	}
}

const $Home = getId("home-display");
const $Repentance = getId("repentance-display");
const $Friends = getId("friends-display");

function deleteDisplay(){
	$Home.style.display = "none";
	$Repentance.style.display = "block";
	$Friends.style.display = "none";
}
deleteDisplay();
for(let i:number = 0; i<$icon.length; i++){
	$icon[i].addEventListener("click", (e)=>{
		iconClick(e);
	});
}










