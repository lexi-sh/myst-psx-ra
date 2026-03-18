// Myst
// #ID = 16200


function numberOnThePanelInTheVideoRoom() => byte(0x1CBEB3)

function imagePtr() => dword(0x07061c)

function hiddenPathRevealed() => byte(0x1cbdfc) == 01

function mechanicalButton1() => byte(0x1cc88e)
function mechanicalButton2() => byte(0x1cc892)
function mechanicalButton3() => byte(0x1cc896)
function mechanicalButton4() => byte(0x1cc89a)
function mechanicalIsAvailableToEnter() => byte(0x1cbe04) == 1


function numBluePagesInserted() => byte(0x0706d0)
function numRedPagesInserted() => byte(0x0706cc)


function notDemo() => imagePtr() != 0x232e

function hiddenPathRevealed() => byte(0x1cbdfc) == 01

function newGame() => prev(imagePtr()) == 0x232a && imagePtr() == 0x2090
function onQuitScreen() => imagePtr() == 0x232a


function interactable() => word(0x07054c)

function inMyst() => dword(0x070438) == 0xabb112a5
function inChan() => dword(0x070438) == 0x0ffb570d
function inSel() => dword(0x070438) == 0x4d4cbfd6
function inMech() => dword(0x070438) == 0xaeb4b6bb
function inShip() => dword(0x070438) == 0xabb112a5
function inDni() => dword(0x070438) == 0x3f146847


function returnedToMyst(p) => imagePtr() == 0xabf2 && prev(imagePtr() == p) && inMyst()

function pn(ptr, val) => ptr == val && prev(ptr) != val

function isOnTitleScreen() => imagePtr() == 0x232a || imagePtr() == 0x232e

/*
Which page is in hand?
  0a == initial blue
  14 == initial red
  0d == mech blue
  17 == mech red
  16 == channelwood red
  0c == channelwood blue
  19 == selenetic red
  0f == selenetic blue
  18 == stoneship red
  0e == stoneship blue
  0b == final blue
  15 == final red
  1e == green page
*/
function pageInHand() => byte(0x1cbdb8)

function catherineNote1() => imagePtr() == 0x00006573 && prev(imagePtr()) == 0x1f8f
function catherineNote2() => imagePtr() == 0x0001654f && prev(imagePtr()) == 0x25b0
achievement(
    title = "Catherine...", points = 1,
    description = "See the note left for Catherine on the ground",
    id = 573090, badge = "672480",
    trigger = (
        catherineNote1() || catherineNote2()
    ) && inMyst() 
)


achievement(
    title = "Something Terrible Has Happened", points = 1, badge="672481",
    description = "See the hidden message from Atrus",
    id = 573091, 
    trigger = (notDemo() && numberOnThePanelInTheVideoRoom() == 8 && pn(interactable(), 0x1f53))
)


achievement(
    title = "Blue Static", points = 2, id=590883, badge="672482",
    description = "Insert a blue page into the book in the library",
    trigger = numBluePagesInserted() > 0 && (
        prev(pageInHand() == 0x0a) ||
        prev(pageInHand() == 0x0b) ||
        prev(pageInHand() == 0x0c) ||
        prev(pageInHand() == 0x0d) ||
        prev(pageInHand() == 0x0e)) && prev(numBluePagesInserted()) == numBluePagesInserted() - 1
      
)

achievement(
    title = "Red Static", points = 2, id=590884, badge="672483",
    description = "Insert a red page into the book in the library",
    trigger = numRedPagesInserted() > 0  && (
        prev(pageInHand() == 0x14) ||
        prev(pageInHand() == 0x15) ||
        prev(pageInHand() == 0x16) ||
        prev(pageInHand() == 0x17) ||
        prev(pageInHand() == 0x18)) && prev(numRedPagesInserted()) == numRedPagesInserted() - 1
)


achievement(
    title = "A Hidden Path!", points = 2, id=582343, badge="672484",
    description = "Looked behind the bookcase",
    trigger = (notDemo() && hiddenPathRevealed() && 
        imagePtr() == 0xb693 && prev(imagePtr()) == 0xbdcd) 
)

achievement(
    title = "The Sky Here Is Dark and Gray", points = 5, id=582342, badge="672485",
    description = "Enter Mechanical",
    trigger = (notDemo() && pn(imagePtr(), 0x438a)
         && mechanicalIsAvailableToEnter())
)


achievement(
    title = "Why's It Always Gotta Be...", points = 2,  badge="672641", description = "Get bitten by a snake?", id=592344,
    trigger = notDemo() && pn(interactable(), 0x6d60) && imagePtr() == 0x54f4
)



function throne1() => pn(imagePtr(), 0xab30) && notDemo()
function throne2() => pn(imagePtr(), 0xa7d6) && notDemo()

achievement(
    title = "You Sit on a Throne of Lies", points = 3,  badge="672642", 
    description = "In a single session, sit upon the brothers' thrones", id=592345,
    trigger = once(throne1()) && once(throne2()) && never(isOnTitleScreen()) && inMech()
)

function mechPuzzleSolveButton() => word(0x070cd8)

achievement(
    title = "Needed a Notebook for This One", points = 10, id=582341, badge="672486",
    description = "Find your way back from Mechanical",
    trigger = (mechanicalButton1() == 2 &&
        mechanicalButton2() == 8 &&
        mechanicalButton3() == 5 &&
        mechanicalButton4() == 1 &&
        imagePtr() == 0x21fc && pn(mechPuzzleSolveButton(), 0xb7b8)) && notDemo()
)

achievement(
    title = "I Hear Only Silence", points = 5, id=590876, badge="672643",
    description = "Enter Selenetic",
    trigger = pn(imagePtr(), 0xb050) && notDemo() && inSel()
)


function endOfSelenetic() => returnedToMyst(0xea16) && byte(0x1cc1ba) == 0x0d

achievement(
    title = "Give Your Ears a Break", points = 10, id=590877, badge="672487",
    description = "Find your way back from Selenetic",
    trigger = endOfSelenetic()
)


/* 
    imageptr = 0xd5a5 => Start over. 
    0x1cc1ba is a number that counts from 01 to 1d as the player moves along the correct maze path
    0x1cc1c2 is a number that represents the last room the user came from, with some reset logic on incorrect paths
    
    If these two memory locations ever equal each other, we know the user has hit an incorrect path, so ResetIf.
*/
achievement(
    title = "It's like Music to My Ears", points = 10, id=590889, badge="672488",
    description = "Make your way through the maze without having to backtrack once",
    trigger = once(imagePtr() == 0xb461) && 
         never(byte(0x1cc1ba) == byte(0x1cc1c2) && byte(0x1cc1c2) > 0 && byte(0x1cc1ba) > 0) && trigger_when(endOfSelenetic())
)


function stoneshipHasRisen() => byte(0x1cbe00) == 1

achievement(
    title = "Emmit Was the First to Live on the Rocks", points = 5, id=590878,
    description = "Enter Stoneship", badge="672489",
    trigger = imagePtr() == 0x0bbc && notDemo() && stoneshipHasRisen() && prev(imagePtr()) == 0x00012cd0
)

achievement(
    title = "Land Ho", points = 10, id=590879, badge="672490",
    description = "Find your way back from Stoneship",
    trigger = returnedToMyst(0x3d33)
)


achievement(
    title = "The Humans and Tree-Dwellers", points = 5, id=590880,
    description = "Enter Channelwood", badge="672644",
    trigger =  prev(imagePtr()) == 0x00012f14 && notDemo() && imagePtr() == 0x6f51 && inChan()
)

function seeingLeftPage() => pn(imagePtr(), 0xc24f) && byte(0x1cc142) == 6
function seeingRightPage() => pn(byte(0x1ccb9e), 01) && imagePtr() == 0x00017fb8


achievement(
    title = "...Vault Access?", points = 5, id=594057, badge="673747",
    description = "Find the right edge of a torn white page",
    trigger = seeingRightPage()
)

achievement(
    title = "Marker..?", points = 5, id=590882, badge="673746",
    description = "Find the left edge of a white torn page",
    trigger = seeingLeftPage()
)

achievement(
    title = "So Many Valves", points = 10, id=590881, badge="672646",
    description = "Find your way back from Channelwood",
    trigger = returnedToMyst(0x18a1e)
)



function finalRedPageEnding() => pn(imagePtr(), 0x00011e22)
function finalBluePageEnding() => pn(imagePtr(), 0x000119c9)

achievement(
    title = "Blue Clarity", points = 10, type="win_condition", id=590886,
    description = "Complete the blue book", badge="672491",
    trigger = finalBluePageEnding() && prev(pageInHand()) == 0x0b && numBluePagesInserted() >= 5
)

achievement(
    title = "Red Clarity", points = 10, type="win_condition", id=590887,
    description = "Complete the red book", badge="672492",
    trigger = finalRedPageEnding() && prev(pageInHand()) == 0x15 && numRedPagesInserted() >= 5
)


achievement(
    title = "The Page...?", points = 10, type="win_condition", id=590888,
    description = "Get stuck in D'ni", badge="672493",
    trigger = imagePtr() == 0x000012e8 && pn(interactable(), 0xafcc)
)


function goodEnding() => prev(pageInHand()) == 0x1e && imagePtr() == 0x000012e8 
    && interactable() == 0xafcd && prev(interactable()) != 0xafcd

achievement(
    title = "You've Done the Right Thing", points = 25, type="win_condition", id=590885,
    description = "Rescue Atrus", badge="672494",
    trigger = goodEnding()
)

achievement(
    title = "There's No Place Like Home", points = 5, id=595547,
    description = "Find your way back to Myst from D'ni", badge="675489",
    trigger = returnedToMyst(0x2b50)
)


function atBeginningOfGame() {
    bridge = byte(0x1cbecb)
    switch1 = byte(0x1cbe08)
    switch2 = byte(0x1cbe09)
    switch3 = byte(0x1cbe0a)
    switch4 = byte(0x1cbe0b)
    switch5 = byte(0x1cbe0c)
    switch6 = byte(0x1cbe0d)
    switch7 = byte(0x1cbe0e)
    switch8 = byte(0x1cbe0f)
    hour = byte(0x1cbebf)
    minute = byte(0x1cbec3)
    return switch1 == 0 &&
        switch2 == 0 &&
        switch3 == 0 &&
        switch4 == 0 &&
        switch5 == 0 &&
        switch6 == 0 &&
        switch7 == 0 &&
        switch8 == 0 && 
        pageInHand() == 0 &&
        bridge == 0 &&
        hour == 0 &&
        minute == 0 &&
        imagePtr() == 0x2090 &&
        prev(imagePtr()) == 0x232a
}

function shouldTickTimer() {
    return dword(0x070620) == 0xffffffff
}

function shouldStopLeaderboard() => (byte(0x0706c0) == 0x0f || byte(0x0706c0) == 0x11) && !atBeginningOfGame()

leaderboard("Rescue Atrus", "", 
    atBeginningOfGame(), 
    shouldStopLeaderboard(), 
    goodEnding(), 
    shouldTickTimer(), 
    format="FRAMES", 
    lower_is_better=true, 
    id=158019)


achievement( 
    title = "When Does Riven Come Out?", points = 25, type="missable", id=592334,
    description = "Rescue Atrus in under 8 minutes", badge="672647",
    trigger = 
        once(atBeginningOfGame()) &&
        once(inDni()) &&
        trigger_when(goodEnding()) && 
        never(byte(0x0706c0) == 0x0f || 
                byte(0x0706c0) == 0x11 || 
                tally(60 * 60 * 8, shouldTickTimer()))
)

