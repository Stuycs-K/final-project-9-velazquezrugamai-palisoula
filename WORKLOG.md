# Work Log

## GROUP MEMBER 1


5/22/23 - Israel Velazquez
worked on a part of the class templates/Worked on printing the map background. Added new classes/changed the variables based on both Mr K's suggestions and ease of convenience (Tiles/Projectiles, and changed String[][] to color[][]).

5/23/23 - Israel Velazquez
Worked on making random maps, adding tiles at random and ending them in on the right side of the screen. Added some visuals to towers/Map to make it visible in processing, I've also added our signature e button into the game.

5/24/23 - Israel Velazquez
Worked on adding a side bar with extra information about the amount of lives/money you have and what round you are in. I also added a normal tower and granted the player the ability to click on the board in order to place their tower.

5/25/23 - Israel Velazquez
Enemies can now appear on the board, and they move like they're supposed to. They don't yet die or get hit, and towers are starting to jump them *literally*, but hey it works somewhat.

5/26/23 - Israel Velazquez
Worked on a more efficient move system, tried to get the towers to be more accurate, and to get them to shoot more often

5/27/2023 - Israel Velazquez
Worked on moving the enemies/projectiles more efficiently to cause less lag, tried to get the projectiles to be more accurate, also tried to verify why the projectiles were so inaccurate

5/29/2023 - Israel Velazquez
Projectile accuracy has increased, enemies now die when shot, enemies also disappear and take away lives when they make it to the end. Two final bugs left however. Towers don't reload their shots unless they hit an enemy, and enemies sometimes increase the amount of lives they have

5/30/2023 - Israel Velazquez
Added a way for the enemies to decrease the life counter. I also tried to decrease the speed of the projectiles so they were more visible.

5/31/2023 - Israel Velazquez
Added a way to win and to lose, added several cheater methods that allow you to gain/lose money, increase/decrease the enemy spawn rate, and make the entire valid board filled with towers. I've also made the enemies scale with each passing round, increasing HP by 1 every 2nd round after round 2, and increasing speed based off of the amount of money the player has. I also added several get() methods to make our code more readable, and fixed the upgraded Towers to make sure to add the towers.

6/1/2023 - Israel Velazquez
Changed all of our direct variables to be accessor methods. Made it so winning doesn't just start the new round with round 10 enemies. Made the projectiles more accurate, and faster. Added comments to all of our methods

6/4/2023 - Israel Velazquez
FIXED THE HP BUG. Enemies spawned in multiple times depending on the amount of possible spawn locations, now that that can't happen, they only spawn in one at a time. I've also added more accessor methods to replace the direct variable we were using. Towers now target the front lines instead of the last ones

6/5/2023 - Israel Velazquez
Added more accessor methods, a radius to help determine the shootable area of the tower, and made the game fullScreen. Added methods in the map area to find specific towers without having to make the loops each time. Re-made it possible for the towers to be upgraded. I also made it to we could see the range of the upgraded tower's as well

6/6/2023 - Israel Velazquez
Added even more accessor methods, gave towers their own menu option, made the screen be based more on SQUARESIZE instead on relying on magic numbers, and I added some work in progress additions for addons.

6/7/2023 - Israel Velazquez
Added a method to return a tower of a type you are looking for. Made the menu look better for a tower.

6/8/2023 / 6/9/2023 - Israel Velazquez
fixed up the upgrade methods in order to make them return values to help with cost calculations. MADE THE TOWERS UPGRADEABLE. They now each have their own little menu that you can use to upgrade each tower and see their range. Made the upgrades stack nicely. Projectiles now shoot extremely precisely. Random green circle in the end is now gone. Game is now too easy.

6/9/2023 - Israel Velazquez - Part2
Hitboxes are bigger, can now buy the different tower varieties. It's slightly finicky, but drawArea() can now also draw the range tower's area. You now have to click the buy tower area to buy a second tower. Made the main sign say 'buy towers' instead of only normal towers. I also centralized it. Added a comment to a method I added

6/12/2023 - Israel Velazquez
Worked on the worklog/DEVLOG, and added some words for clarity in the README

info


## GROUP MEMBER 2


5/22/23 - Allison Palisoul

worked on most of the smaller methods (changePierce, recieveDamage, etc.) and changed variables (ex: removed Tower tow in validPlacement and changed obj in changeBoard from a Map to an Object)


5/23/23

added an addTower method, did keyPressed (pressing key skips round), edited validPlacement

5/24/23

finished validPlacement, fixed merge conflicts, added comments to the methods that they're necessary. Also changed the color of the map and plan on changing the "you have given up" message to a different font.

5/25/23

worked on Enemy.move() function so that they can move along the path. also centered "you have given up" and changed the font :D, fixed validPlacement bug

5/26/23

made the font consistent, attempted to make a static class for variables but it was too buggy

5/27/23

started working on way to upgrade towers (Map.canUpgrade(), towerDefense.upTower(), adding to mouseClicked())

5/30/23

finished debugging upgrade component, added explosion picture to giveup() and removed unneeded files.

5/31/23

added a feature where the color of upgrade and new tower changed based on mode, game now always starts on "Buy new towers".

6/6/23

changed the winscreen text to green, created different types of upgrades (ex: increased damage, decreased reload time), fixed aesthetic issues.

6/7/23

made dropdown drop down; continued working to include multiple types of upgrades

6/9/23

added comments where necessary, centered win and lose messages

6/11/23

finished the final UML, edited the README

6/12/23

worked on the DEVLOG


##Working Features
-The hotkeys listed in the README all work :D (m, l, ',', '.', '\\', e, and ' ')
-Selecting towers/upgrades
-Upgrading towers
-Shows the tower's radius before placing
-Enemies gain HP on certain rounds
-Enemies gain speed once you have 700$ or more

##Broken Features/bugs
-Depending on the size of your screen, you may not be able to see the enemies when they are in the bottom row.
-If you press space during a cutscene, it will start a new round. Cutscene's are the explosion

##Content resources
-Processing's Reference Page --> https://processing.org/reference/
It was extremely helpful while trying to figure out why certain methods wouldn't work, and for finding new features to work with the features we already added
