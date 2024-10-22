//
module DragonQuest::DragonQuestMain {
    use std::string::String;

    // error message
    const LEVEL_NOT_HIGH_ENOUGH:u64 = 1; // level of the user is not high enough and must level up before proceeding

    // add companion struct to then be attached to the character.
    public struct Character has key {
        id: UID,
        adventures_name: String,
        adventures_level: u64,
        experience_points: u64,
        in_cave: bool,
        //companion: dragon struct
    } 

    public fun create_character(adventures_name: String, ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx); // Get the sender's ID
        // add a check to see if the signer address has a active player

        let character = Character {
            id: sui::object::new(ctx),
            adventures_name,
            adventures_level: 0,
            experience_points: 0,
            in_cave: false,
        };
        transfer::transfer(character, tx_context::sender(ctx));
    }
    
   public fun generate_random(ctx: &mut TxContext): u64 {
    let hash_value: u64 = ctx.epoch() % 100; // Generate a pseudo-random number between 0-99
    hash_value // Return the hash_value, which is a u64
    }

    public fun gain_experience(character: &mut Character, ctx: &mut TxContext) {
        character.experience_points + 1;
        let level_1 = 5;
        let level_2 = 10;
        if (character.experience_points >= level_1) {
            character.adventures_level + 1 ;
        };
        if (character.experience_points >= level_2) {
            character.adventures_level + 1;
        };
    }
    public fun enter_cave(character: &mut Character, ctx: &mut TxContext) {
        let characterLevel = character.adventures_level;
        if (characterLevel >= 2) {
            character.in_cave = true
        } else {
            abort(LEVEL_NOT_HIGH_ENOUGH)
            }
    }

}