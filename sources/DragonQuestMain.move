//
module DragonQuest::DragonQuestMain {
    use std::string::{Self, String};
    use DragonQuest::BalanceManager;
    use sui::table;

    // error message
    const LEVEL_NOT_HIGH_ENOUGH:u64 = 1; // level of the user is not high enough and must level up before proceeding
    const NOT_IN_CAVE:u64 = 2; // user or character not in cave already, need to enter cave to exit cave

    // add companion struct to then be attached to the character.
    public struct Character has key {
        id: UID,
        adventures_name: String,
        adventures_level: u64,
        experience_points: u64,
        in_cave: bool,
        //companion: dragon struct
    } 
    public struct Rarity_table {
        rarity: table::Table<u8, bool>,
    }
    public struct Dragon_egg has key, store {
        id:UID, 
        rarity: u8,
        nature_type: String,
        larger_number: u64,
    }

    public fun create_character(adventures_name: String, ctx: &mut TxContext) {
       // let sender = tx_context::sender(ctx); // Get the sender's ID
        // add a check to see if the signer address has a active player

        let character = Character {
            id: sui::object::new(ctx),
            adventures_name,
            adventures_level: 1, // new characters start at level 1
            experience_points: 0,
            in_cave: false,
        };
        transfer::transfer(character, tx_context::sender(ctx));
    }
    public fun get_dragon_egg(ctx: &mut TxContext) {
        let recipient = tx_context::sender(ctx);
        // create a check to ensure that the rarity number called is not already used, if so, re call.
        let rarity:u8 = BalanceManager::generate_number_for_rarity(ctx);

        // create a if statement to determine the nature of the dragon.
        let nature_number:u8 = BalanceManager::generate_number_for_nature(ctx);
        let mut nature = string::utf8(b"Earth");
        if (nature_number == 1) {
            nature = string::utf8(b"Fire");
        };
        if (nature_number == 2) {
            nature = string::utf8(b"Wind");
        };
        if (nature_number == 3) {
            nature = string::utf8(b"Ghost");
        };
        if (nature_number == 4) {
            nature = string::utf8(b"Demon");
        }; // these values should change... need testing.
        let larger_number = BalanceManager::generate_number_for_larger(ctx);
        let dragon_egg = Dragon_egg {
            id: object::new(ctx),
            rarity,
            nature_type: nature,
            larger_number
        };
        transfer::transfer(dragon_egg, recipient)
    }
    
   public fun generate_random(ctx: &mut TxContext): u64 {
    let hash_value: u64 = ctx.epoch() % 100; // Generate a pseudo-random number between 0-99
    hash_value // Return the hash_value, which is a u64
    }

    public fun gain_experience(character: &mut Character, _ctx: &mut TxContext) {
        // gains 1 experience point
        character.experience_points = character.experience_points + 1;
        // setting the experience until level up
        let level_1 = 5;
        let level_2 = 10;
        if (character.experience_points >= level_1) {
            character.adventures_level = character.adventures_level + 1 ;
        };
        if (character.experience_points >= level_2) { // this is now skipping , need to fix
            character.adventures_level = character.adventures_level + 1;
        };
    }
    public fun enter_cave(character: &mut Character, _ctx: &mut TxContext) {
        let characterLevel = character.adventures_level;
        if (characterLevel >= 2) {
            character.in_cave = true;
        } else {
            abort(LEVEL_NOT_HIGH_ENOUGH)
            }
    }
    public fun exit_cave(character: &mut Character, _ctx: &mut TxContext) {
        let is_in_cave:bool = character.in_cave;
        if (is_in_cave) {
            character.in_cave = false;
        } else {
            abort(NOT_IN_CAVE)
            }
    }

}