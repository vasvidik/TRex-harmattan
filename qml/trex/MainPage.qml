import QtQuick 1.1
import com.nokia.meego 1.1

Page {

	property int score: 0
	property bool dinostart: false
	property bool dinorunning: false

    property int dino_width: 94
    property int dino_height: 100
	property int dino_x: 50
	property int dino_y: 300

    property int cactus1_width: 39
	property int cactus1_height: 80
    property int cactus1_x: 854
    property int cactus1_y: dino_y+dino_height-cactus1_height

    property int cactus2_width: 82
    property int cactus2_height: 80
    property int cactus2_x: 1000
    property int cactus2_y: dino_y+dino_height-cactus2_height

    property int cactus3_width: 45
    property int cactus3_height: 90
    property int cactus3_x: 1000
    property int cactus3_y: dino_y+dino_height-cactus3_height

    property int cloud_x: 300
    property int cloud_y: 40
    property int cloud_height: 45
    property int cloud_width: 88

    property int movingspeed: 3
    property int movingspeed_start: 3

    property int cactus2_start_interval: 1500
    property int cactus2_interval: 1500

    property int cactus3_start_interval: 500
    property int cactus3_interval: 500

    property int prejump_dino_x: 0

    property bool dino_acceleration: false

    property string dino_status: "Jump"

    Rectangle
    {
        id: land1
        height: 32
        width: 3200
        x: 0
        y: dino_y+dino_width-5
        color: "transparent"
        Image {
            id: landImage1
            source: "./images/Land.png"
        }
    }

    Rectangle
    {
        id: land2
        height: 32
        width: 3200
        x: 854
        y: dino_y+dino_width-5
        color: "transparent"
        Image {
            id: landImage2
            source: "./images/Land.png"
        }
    }

    Rectangle
    {
        id: cloud
        height: cloud_height
        width: cloud_width
        x: cloud_x
        y: cloud_y
        color: "transparent"
        Image {
            id: cloudImage
            source: "./images/Cloud.png"
        }
    }

	Rectangle
	{
		id: dino
		width: dino_width
		height: dino_height
        color: "transparent"
		x: dino_x
		y: dino_y
        Image {
            id: dinoImageJump
            source: "./images/TrexJump.png"
            visible: true
        }
        Image {
            id: dinoImageRun1
            source: "./images/TrexRun1.png"
            visible: false
        }
        Image {
            id: dinoImageRun2
            source: "./images/TrexRun2.png"
            visible: false
        }
        Image {
            id: dinoImageDied
            source: "./images/TrexDied.png"
            visible: false
        }
	}

    function dinoImage(dino_status)
    {
        switch(dino_status)
        {
            case "Jump":
                dinoImageDied.visible=false;
                dinoImageRun1.visible=false;
                dinoImageRun2.visible=false;
                dinoImageJump.visible=true;
                break;
            case "Died":
                dinoImageDied.visible=true;
                dinoImageRun1.visible=false;
                dinoImageRun2.visible=false;
                dinoImageJump.visible=false;
                break;
            case "Run1":
                dinoImageDied.visible=false;
                dinoImageRun1.visible=true;
                dinoImageRun2.visible=false;
                dinoImageJump.visible=false;
                break;
            case "Run2":
                dinoImageDied.visible=false;
                dinoImageRun1.visible=false;
                dinoImageRun2.visible=true;
                dinoImageJump.visible=false;
                break;
            default:
                dinoImageDied.visible=false;
                dinoImageRun1.visible=false;
                dinoImageRun2.visible=false;
                dinoImageJump.visible=true;
                break;
        }

    }

	Rectangle
	{
		id: cactus1
		width: cactus1_width
		height: cactus1_height
		x: cactus1_x
        y: cactus1_y
        color: "transparent"
        Image {
            id: cactus1Image
            source: "./images/Cactus1.png"
        }
	}

    Rectangle
    {
        id: cactus2
        width: cactus2_width
        height: cactus2_height
        x: cactus2_x
        y: cactus2_y
        color: "transparent"
        Image {
            id: cactus2Image
            source: "./images/Cactus2.png"
        }
    }

    Rectangle
    {
        id: cactus3
        width: cactus3_width
        height: cactus3_height
        x: cactus3_x
        y: cactus3_y
        color: "transparent"
        Image {
            id: cactus3Image
            source: "./images/Cactus3.png"
        }
    }

	Timer
	{
        id: cactus1moving
        running: dinorunning
		repeat: true
		interval: 1
		onTriggered:
		{
            if(cactus1.x>=-cactus1_width)cactus1.x-=movingspeed;
            else cactus1.x=cactus1_x;
		}
    }

    Timer
    {
        id: cactus2moving
        running: false
        repeat: true
        interval: 1
        onTriggered:
        {
            if(cactus2.x>=-cactus2_width)cactus2.x-=movingspeed;
            else
            {
                cactus2.x=cactus2_x;
                cactus2moving.running=false;
            }
        }
    }

    Timer
    {
        id: cactus2interval
        running: dinorunning
        repeat: true
        interval: cactus2_interval
        onTriggered:
        {
            if(cactus1.x<=654 && cactus1.x>=350)
                cactus2moving.running=true;
            else;
            cactus2_interval=(cactus2_interval/2*3/7*5);
        }
    }

    Timer
    {
        id: cactus3moving
        running: false
        repeat: true
        interval: 1
        onTriggered:
        {
            if(cactus3.x>=-cactus3_width)cactus3.x-=movingspeed;
            else
            {
                cactus3.x=cactus3_x;
                cactus3moving.running=false;
            }
        }
    }

    Timer
    {
        id: cactus3interval
        running: dinorunning
        repeat: true
        interval: cactus3_interval
        onTriggered:
        {
            if(cactus1.x<=654 && cactus1.x>=350 && cactus2.x<=654 && cactus2.x>=350)
                cactus3moving.running=true;
            else;
            cactus3_interval=(cactus3_interval/37*35);
        }
    }

    Timer
    {
        id: landmoving1
        running: false
        repeat: true
        interval: 1
        onTriggered:
        {
            if(land1.x+land1.width<-2)
            {
                land1.x=854;
                landmoving1.running=false;
            }
            else if(land1.x>=-land1.width+860 && land1.x+land1.width>=-2) land1.x-=movingspeed;
            else
            {
                land1.x-=movingspeed;
                landmoving2.running=true;
            }
        }
    }

    Timer
    {
        id: landmoving2
        running: false
        repeat: true
        interval: 1
        onTriggered:
        {
            if(land2.x+land2.width<-2)
            {
                land2.x=854;
                landmoving2.running=false;
            }
            else if(land2.x>=-land2.width+860 && land2.x+land2.width>=-2) land2.x-=movingspeed;
            else
            {
                land2.x-=movingspeed;
                landmoving1.running=true;
            }
        }
    }

    Timer
    {
        id: cloudmoving
        running: dinorunning
        repeat: true
        interval: 150
        onTriggered:
        {
            if(cloud.x>=-cloud_width)cloud.x-=movingspeed;
            else cloud.x=855;
        }
    }

	Timer
	{
		id: scorechange
		running: dinorunning
		repeat: true
        interval: 100
		onTriggered:
		{
			score++;
			scoreoutput.text=score;
		}
	}

	Timer
	{
		id: dinoupjumping
		running: false
		repeat: true
        interval: 1
		onTriggered:
		{
            if(dino.y<=dino_y-dino_height-50)
			{
				dinoupjumping.running=false;
				dinodownjumping.running=true;
			}
            else
            {
                /*if(dino.y===dino_y)
                    dino.y-=10;
                else if(dino.y<=dino_y-10 && dino.y>=dino_y-24)
                    dino.y-=7;
                else if(dino.y<=dino_y-24 && dino.y>=dino_y-40)
                    dino.y-=4;
                else if(dino.y<=dino_y-44)
                    dino.y--; */

                dino.y-=movingspeed;
            }
		}
	}

	Timer
	{
		id: dinodownjumping
		running: false
		repeat: true
        interval: 1
		onTriggered:
		{
            if(dino.y==dino_y)
            {
                dinodownjumping.running=false;
                dinorunanimation.running=true;
            }
            else
            {
                /*
                if(dino.y===dino_y)
                    dino.y+=10;
                else if(dino.y<=dino_y-10 && dino.y>=dino_y-24)
                    dino.y+=7;
                else if(dino.y<=dino_y-24 && dino.y>=dino_y-40)
                    dino.y+=4;
                else if(dino.y<=dino_y-44)
                    dino.y++; */
                dino.y+=movingspeed;
            }
		}
	}

	Timer
	{
		id: dinolive
		running: dinorunning
		repeat: true
		interval: 1
		onTriggered:
        {
			if(dino.y+dino.height<cactus1.y);  // проверка по y
			else
			{
				if(dino.x>cactus1.x+cactus1.width || dino.x+dino.width<cactus1.x); // проверка по x - левый край dino правее правого края cactus1
                else if((dino.y+0.4*dino.height<cactus1.y) && (dino.x+0.6*dino.width<cactus1.x));
                else if((dino.y+0.5*dino.height<cactus1.y) && (dino.x+0.4*dino.width>cactus1.x+cactus1.width));
                else
				{
					dinorunning=false;
                    landmoving1.running=false;
                    landmoving2.running=false;
                    dinorunanimation.running=false;
                    cactus2moving.running=false;
                    cactus3moving.running=false;
                    dinoupjumping.running=false;
                    dinodownjumping.running=false;
                    dinoImage("Died");
					failedDialog.open();
				}
			}

            if(dino.y+dino.height<cactus2.y);  // проверка по y
            else
            {
                if(dino.x>cactus2.x+cactus2.width || dino.x+dino.width<cactus2.x); // проверка по x - левый край dino правее правого края cactus2
                else if((dino.y+0.4*dino.height<cactus2.y) && (dino.x+0.6*dino.width<cactus2.x));
                else if((dino.y+0.5*dino.height<cactus2.y) && (dino.x+0.4*dino.width>cactus2.x+cactus2.width));
                else
                {
                    dinorunning=false;
                    landmoving1.running=false;
                    landmoving2.running=false;
                    dinorunanimation.running=false;
                    cactus2moving.running=false;
                    cactus3moving.running=false;
                    dinoupjumping.running=false
                    dinodownjumping.running=false
                    dinoImage("Died");
                    failedDialog.open();
                }
            }

            if(dino.y+dino.height<cactus3.y);  // проверка по y
            else
            {
                if(dino.x>cactus3.x+cactus3.width || dino.x+dino.width<cactus3.x); // проверка по x - левый край dino правее правого края cactus3
                else if((dino.y+0.4*dino.height<cactus3.y) && (dino.x+0.6*dino.width<cactus3.x));
                else if((dino.y+0.5*dino.height<cactus3.y) && (dino.x+0.4*dino.width>cactus3.x+cactus3.widht));
                else
                {
                    dinorunning=false;
                    landmoving1.running=false;
                    landmoving2.running=false;
                    dinorunanimation.running=false;
                    cactus2moving.running=false;
                    cactus3moving.running=false;
                    dinoupjumping.running=false
                    dinodownjumping.running=false
                    dinoImage("Died");
                    failedDialog.open();
                }
            }
		}

    }

    function dinorunimage()
    {
        if(dinoImageDied.visible===true || dinoImageJump.visible===true || dinoImageRun2.visible===true)
            dinoImage("Run1");
        else if(dinoImageRun1.visible===true)
            dinoImage("Run2");
        else;
    }

    Timer
    {
        id: dinorunanimation
        running: dinorunning
        repeat: true
        interval: 100
        onTriggered: dinorunimage();
    }

	Timer
	{
		id: pause
		running: false
		repeat: false
        interval: 200
        onTriggered:
        {
            dinoImage("Jump");
            dinorunning=true;
            dinorunanimation.running=true;
            landmoving1.running=true;
        }
	}

    Timer
    {
        id: acceleration
        running: dinorunning
        repeat: true
        interval: 1
        onTriggered:
        {
            if(score!==0 && (score%500)===0 && dino.y<dino_y)
                dino_acceleration=true;
            else if(dino.y===dino_y && dino_acceleration===true)
            {
                dino_acceleration=false;
                movingspeed++;
            }
            else if(score!==0 && (score%500)===0 && dino.y===dino_y)
                movingspeed++;
            else;

        }
    }

	MouseArea
	{
		anchors.fill: parent
		onClicked:
		{
			if(dinostart==false)
			{
                dinorunning=true;
                landmoving1.running=true;
                dinostart=true;
			}
			else
			{
                if(dinorunning==true && dinodownjumping.running==false && dinoupjumping.running==false)
                {
                    dinoupjumping.running=true;
                    dinoImage("Jump");
                    dinorunanimation.running=false;
                }
				else;
			}
		}
	}

	Label
	{
		id: scoreoutput
		x: 0
		y: 0
		text: "0"
	}

    Label{
        id: startLabel
        anchors.horizontalCenter: parent.horizontalCenter
        y: 60
        visible: (dinostart===true) ? false : true
        text: "Нажмите чтобы начать"
        font.family: "NokiaSans"
        font.pixelSize: 40
    }

	QueryDialog
	{
		id: failedDialog
		acceptButtonText: "Начать заново"
		titleText: "Игра окончена"
		message: "Ваш счет: "+ score
		onAccepted:
		{
			dino.x=dino_x;
			dino.y=dino_y;
            cactus1.x=cactus1_x;
            cactus2.x=cactus2_x;
            cactus3.x=cactus3_x;
            land2.x=854;
            land1.x=0;
            movingspeed=movingspeed_start;
            cactus2_interval=cactus2_start_interval;
            cactus3_interval=cactus3_start_interval;
			pause.running=true;
			score=0;
		}
	}




}
