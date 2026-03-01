// Myst
// #ID = 16200


function numberOnThePanelInTheVideoRoom() => byte(0x1CBEB3)
// 0x06feb0-0x070cea
function imagePtr() => dword(0x07061c)

function hiddenPathRevealed() => byte(0x1cbdfc) == 01

function mechanicalButton1() => byte(0x1cc88e)
function mechanicalButton2() => byte(0x1cc892)
function mechanicalButton3() => byte(0x1cc896)
function mechanicalButton4() => byte(0x1cc89a)
function mechanicalIsAvailableToEnter() => byte(0x1cbe04) == 1


function numBluePagesInserted() => byte(0x0706d0)
function numRedPagesInserted() => byte(0x0706cc)



function notDemo() => word(0x070434) != 0x090c

function hiddenPathRevealed() => byte(0x1cbdfc) == 01


function catherineNote1() => imagePtr() == 0x00006573 && prev(imagePtr()) == 0x1f8f
function catherineNote2() => imagePtr() == 0x0001654f && prev(imagePtr()) == 0x25b0

achievement(
    title = "Catherine...", points = 1, type="progression",
    description = "See the note left for Catherine on the ground",
    id = 573090, badge = "00000", published = "1/12/2026 4:07:54 PM", modified = "1/12/2026 4:07:54 PM",
    trigger = (
        catherineNote1() || catherineNote2()
    ) && notDemo()
)


function hologramProjectorState() => byte(0x1cc012)

achievement(
    title = "Something Terrible Has Happened", points = 1,
    description = "See the hidden message from Atrus",
    id = 573091, badge = "00000", published = "1/12/2026 4:07:54 PM", modified = "1/12/2026 4:07:54 PM",
    trigger = (notDemo() && numberOnThePanelInTheVideoRoom() == 8 && 
        hologramProjectorState() == 1 && prev(hologramProjectorState() == 0))
)

achievement(
    title = "A Hidden Path!", points = 2,
    description = "\"If you forgot the access keys, remember the tower rotation\"",
    trigger = (notDemo() && hiddenPathRevealed())
)

achievement(
    title = "What Was it All For?", points = 5,
    description = "Enter Mechanical",
    trigger = (notDemo() && imagePtr() == 0x438a
         && mechanicalIsAvailableToEnter())
)

function mechPuzzleSolveButton() => word(0x070cd8)

achievement(
    title = "Needed a Notebook for This One", points = 10,
    description = "Solve the puzzle of Mechanical",
    trigger = (mechanicalButton1() == 2 &&
        mechanicalButton2() == 8 &&
        mechanicalButton3() == 5 &&
        mechanicalButton4() == 1 &&
        imagePtr() == 0x21fc && mechPuzzleSolveButton() == 0xb7b8) && notDemo()
)

achievement(
    title = "We're Jammin'", points = 5,
    description = "Enter Selenetic",
    trigger = always_false()
)

achievement(
    title = "Give your Ears a Break", points = 0,
    description = "Find your way back from Selenetic",
    trigger = always_false()
)

function stoneshipHasRisen() => byte(0x1cbe00) == 1

achievement(
    title = "Ahoy Matey", points = 5,
    description = "Enter Stoneship",
    trigger = imagePtr() == 0x0bbc && notDemo() && stoneshipHasRisen() && prev(imagePtr()) == 0x00012cd0
)

function stoneship135degPressed() => byte(0x1cc072) == 1

achievement(
    title = "Land Ho", points = 10,
    description = "Find your way back from Stoneship",
    trigger = imagePtr() == 0xabf2 && prev(imagePtr()) == 0x3d33 && notDemo() && once(stoneship135degPressed())
)


achievement(
    title = "Now We're Cooking with Gas", points = 5,
    description = "Enter Channelwood",
    trigger =  prev(imagePtr()) == 0x00012f14 && notDemo() && imagePtr() == 0x6f51
)

achievement(
    title = "A Swamp for You and Me", points = 0,
    description = "Find your way back from Channelwood",
    trigger = imagePtr() == 0xabf2 && prev(imagePtr()) == 0x18a1e && notDemo()
)


function seeingLeftPage() => imagePtr() == 0xc24f && byte(0x1cc142) == 6
function seeingRightPage() => byte(0x1ccb9e) == 01 && imagePtr() == 0x00017fb8


achievement(
    title = "Putting Two and Two Together", points = 10,
    description = "See all parts of the white page",
    trigger = once(seeingLeftPage()) && once(seeingRightPage())
)

achievement(
    title = "Blue Static", points = 2,
    description = "Insert a blue page into the book in the library",
    trigger = numBluePagesInserted() > 0
)

achievement(
    title = "Red Static", points = 2,
    description = "Insert a red page into the book in the library",
    trigger = numRedPagesInserted() > 0
)

function finalRedPageEnding() => imagePtr() == 0x00011e22

function finalBluePageEnding() => imagePtr() == 0x000119c9

achievement(
    title = "That Doesn't Seem Right...", points = 10, type="win_condition",
    description = "Finish the game with a bad ending",
    trigger = notDemo() && (finalRedPageEnding() || finalBluePageEnding())
)

function pageInHand() => byte(0x1cbdb8)
function interactable() => word(0x07054c)

achievement(
    title = "You've Done the Right Thing", points = 25, type="win_condition",
    description = "Finish the game with the good ending",
    trigger = prev(pageInHand()) == 0x1e && imagePtr() == 0x000012e8 && interactable() == 0xafcd
)

achievement(
    title = "Do I trust him...? (Blue)", points = 10,
    description = "Complete the blue book",
    trigger = numBluePagesInserted() == 5
)

function redBookPages() => byte(0x0706cc)

achievement(
    title = "Do I trust him...? (Red)", points = 10,
    description = "Complete the red book",
    trigger = numRedPagesInserted() == 5
)

achievement(
    title = "The Page...?", points = 10, type="win_condition",
    description = "Forget to bring the page before entering the final book",
    trigger = imagePtr() == 0x000012e8 && interactable() == 0xafcc
)

achievement(
    title = "Am I hearing Things?", points = 10,
    description = "Make your way through the maze without having to backtrack once",
    trigger = always_false()
)

achievement(
    title = "When Does Riven Come Out?", points = 25, type="missable",
    description = "Finish the game with the good ending in under 4 minutes",
    trigger = always_false()
)


achievement(
    title = "Why's it Always Gotta be...", points = 2, description = "Get bitten by a snake?",
    trigger = notDemo() && interactable() == 0x6d60 && imagePtr() == 0x54f4
)

function throne1() => imagePtr() == 0xab30 && notDemo()
function throne2() => imagePtr() == 0xa7d6 && notDemo()

achievement(
    title = "You Sit on a Throne of Lies", points = 3, description = "Sit upon the brothers' thrones",
    trigger = once(throne1()) && once(throne2())
)
