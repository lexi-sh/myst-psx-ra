// Myst
// #ID = 16200

// $1CB6D0: Tower Rotation-- 0-180 degrees
function towerRotation0_180Degrees() => byte(0x1CB6D0)

// $1CB6D1: Tower Rotation-- Positive or Negatve
function towerRotationPositiveOrNegatve() => byte(0x1CB6D1)

// $1CBBCC: Observatory: Month
function observatoryMonth() => byte(0x1CBBCC)

// $1CBBD0: Observatory: 16-bit Year
function observatory16BitYear() => word(0x1CBBD0)

// $1CBBD4: Observatory: Day of Month
function observatoryDayOfMonth() => byte(0x1CBBD4)

// $1CBBD8: Observatory: 16-bit Time
function observatory16BitTime() => word(0x1CBBD8)

// $1CBE00: Stoneship Ship has Risen
function stoneshipShipHasRisen() => byte(0x1CBE00)

// $1CBE08: Switch State: Dock
function switchStateDock() => byte(0x1CBE08)

// $1CBE09: Switch State: Mechanical Gear
function switchStateMechanicalGear() => byte(0x1CBE09)

// $1CBE0A: Switch State: Observatory
function switchStateObservatory() => byte(0x1CBE0A)

// $1CBE0B: Switch State: Boat Well
function switchStateBoatWell() => byte(0x1CBE0B)

// $1CBE0C: Switch State: Power Generator
function switchStatePowerGenerator() => byte(0x1CBE0C)

// $1CBE0D: Switch State: Rocket
function switchStateRocket() => byte(0x1CBE0D)

// $1CBE0E: Switch State: Channelwood Cabin
function switchStateChannelwoodCabin() => byte(0x1CBE0E)

// $1CBE0F: Switch State: Clocktower
function switchStateClocktower() => byte(0x1CBE0F)

// $1CBE14: Voltage Output
function voltageOutput() => byte(0x1CBE14)

// $1CBE20: Voltage Input-- used for calculations
function voltageInputUsedForCalculations() => byte(0x1CBE20)

// $1CBE24: Voltage Input-- used for displaying to the screen
function voltageInputUsedForDisplayingToTheScreen() => byte(0x1CBE24)

// $1CBE35: 1 if input voltage == 59, else 0
function ifInputVoltage59Else0() => byte(0x1CBE35)

// $1CBEB3: Number on the panel in the video room
function numberOnThePanelInTheVideoRoom() => byte(0x1CBEB3)

// $1CBEBF: Clocktower: Hour Hand Position
function clocktowerHourHandPosition() => byte(0x1CBEBF)

// $1CBEC3: Clocktower: Minute Hand Position
function clocktowerMinuteHandPosition() => byte(0x1CBEC3)

// $1CBEE4: Wall Safe: Hundreds Values
function wallSafeHundredsValues() => byte(0x1CBEE4)

// $1CBEE8: Wall Safe: Ones Value
function wallSafeOnesValue() => byte(0x1CBEE8)

// $1CBEEC: Wall Safe: Tens Value
function wallSafeTensValue() => byte(0x1CBEEC)

// $1E2BD4: 16 bit Pointer to Image on Screen
function mystPtr() => word(0x1ccc2c)
function mechPtr() => word(0x1dd8ec)
function stonePtr() => word(0x1ddb28)

function hiddenPathRevealed() => byte(0x1cbdfc) == 01

function mechanicalButton1() => byte(0x1cc88e)
function mechanicalButton2() => byte(0x1cc892)
function mechanicalButton3() => byte(0x1cc896)
function mechanicalButton4() => byte(0x1cc89a)
function mechanicalIsAvailableToEnter() => byte(0x1cbe04) == 1

function newGameStart() => word(0x1d18a0) // 0001, -> aaac -> 0000 means new game

function notDemo() => mystPtr() != 0x2a23

function hiddenPathRevealed() => byte(0x1cbdfc) == 01


function catherineNote1() => mystPtr() == 0x6573 && prev(mystPtr()) == 0x1f8f
function catherineNote2() => mystPtr() == 0x654f && prev(mystPtr()) == 0x25b0

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
    trigger = (notDemo() && mystPtr() == 0x4120
        && mechPtr() == 0x24a0 && mechanicalIsAvailableToEnter())
)

achievement(
    title = "Needed a Notebook for This One", points = 10,
    description = "Solve the puzzle of Mechanical",
    trigger = (mechanicalButton1() == 2 &&
        mechanicalButton2() == 8 &&
        mechanicalButton3() == 5 &&
        mechanicalButton4() == 1 &&
        mechPtr() == 0x2814) && notDemo()
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

achievement(
    title = "Ahoy Matey", points = 5,
    description = "Enter Stoneship",
    trigger = stonePtr() == 0xfd6c && notDemo()
)

achievement(
    title = "Land Ho", points = 10,
    description = "Find your way back from Stoneship",
    trigger = stonePtr() == 0x0134
)


achievement(
    title = "Now We're Cooking with Gas", points = 5,
    description = "Enter Channelwood",
    trigger =  prev(mystPtr()) == 0x2f14 && notDemo() && mystPtr() == 0x6c50   
        && prev(mystPtr()) != mystPtr()
)

achievement(
    title = "A Swamp for You and Me", points = 0,
    description = "Find your way back from Channelwood",
    trigger = always_false()
)

achievement(
    title = "Putting Two and Two Together", points = 0,
    description = "See all parts of the white page",
    trigger = always_false()
)

achievement(
    title = "Blue Static", points = 0,
    description = "Insert a blue page into the book in the library",
    trigger = always_false()
)

achievement(
    title = "Red Static", points = 0,
    description = "Insert a blue page into the book in the library",
    trigger = always_false()
)

achievement(
    title = "That Doesn't Seem Right...", points = 0, type="win_condition",
    description = "Finish the game with a bad ending",
    trigger = always_false()
)

achievement(
    title = "You've Done the Right Thing", points = 0, type="win_condition",
    description = "Finish the game with the good ending",
    trigger = always_false()
)

achievement(
    title = "Do I trust him? (Blue)", points = 0,
    description = "Complete the blue book",
    trigger = always_false()
)

function redBookPages() => byte(0x0706cc)

achievement(
    title = "Do I trust him? (Red)", points = 0,
    description = "Complete the red book",
    trigger = always_false()
)

achievement(
    title = "Note Collector", points = 0,
    description = "Read all the notes scattered throughout the ages",
    trigger = always_false()
)

achievement(
    title = "The Page...?", points = 0, type="win_condition",
    description = "Forget to bring the page before entering the final book",
    trigger = always_false()
)

achievement(
    title = "No Whammies", points = 0, type="missable",
    description = "Get into the rocket without blowing the fuses once",
    trigger = (
        always_false()
    )
)

achievement(
    title = "Am I hearing Things?", points = 0, type="missable",
    description = "Make your way through the maze without having to backtrack once",
    trigger = always_false()
)

achievement(
    title = "When Does Riven Come Out?", points = 0, type="missable",
    description = "Finish the game with the good ending in under 4 minutes",
    trigger = always_false()
)

function mechPtr2() => word(0x1ce60c)
achievement(
    title = "Why's it Always Gotta be...", points = 2, description = "Get bitten by a snake?",
    trigger = prev(mechPtr2()) == 0x311a && notDemo() && mechPtr2() == 0x641a
)

