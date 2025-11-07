# Candy Run  
*A Halloween platformer*

---

## Game Overview

**Candy Run** is a 2D side-scrolling platformer inspired by the first level of *Super Mario Bros.*  
Your goal is to collect enough candy for trick-or-treaters before the night begins, and make it home safely!

Jump across spooky blocks, avoid roaming ghosts, and race against time to fill your candy bowl before the trick-or-treaters arrive.

---

## Story

> The candy bowl is empty and trick-or-treaters will be here any minute!  
> Run through the neighborhood, collect all the candy, and get home before the night ends.  
> Beware—the ghosts don’t like to share!

---

## How to Play

| Action | Key |
|:--|:--|
| Move Left | ← Arrow / A |
| Move Right | → Arrow / D |
| Jump | Spacebar |

- **Collect all candy** scattered throughout the level.  
- **Avoid ghosts** — touching one costs a life.  
- You start with **3 lives**. Lose them all, and you’ll restart from the beginning.  
- Once you’ve collected **all candy**, enter the house to win the game.

---

## Features Implemented

**Custom Art Assets**
- Player, Ghosts, Background, Ground/Blocks-all original.

**TileMap System**
- Built using a custom `tiles_candy_run.png` TileSet, based on the layout of *Super Mario Bros.* 1-1.

**Player System**
- Movement, jumping, gravity, and sprite flipping when changing direction.

**Enemies**
- Ghosts patrol platforms, turn around when colliding with obstacles, and damage the player on any contact.

**Pickups**
- Candy items emit a signal when collected, disappear, and update the HUD counter.

**HUD**
- Displays both **Candy Counter** and **Lives Counter** at the top of the screen.

**Cutscenes / Story Scenes**
- **Start Scene**: Intro text and “Start Game” button.  
- **Ending Scene**: Displays “You made it!” message upon victory.

**Game Logic**
- Lives system with respawn and game-over restart.  
- Goal checks candy count before allowing win.  
- On-screen messages for feedback (e.g., “Ouch! You lost a life.” / “You haven’t collected all the candy yet!”).

---

## Learning Objectives Demonstrated

- Creating and configuring a **TileSet** and **TileMap** in Godot 4.  
- Implementing collisions and physics with **CharacterBody2D** and **Area2D**.  
- Using **signals** for pickups, collisions, and event-driven gameplay.  
- Building a **HUD** with dynamic labels for lives and collectibles.  
- Structuring a multi-scene game (Start, Main, Ending).  
- Managing **scene transitions**, **respawn logic**, and **game states**.

---
