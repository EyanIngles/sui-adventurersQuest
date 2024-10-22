//
module DragonQuest::DragonQuestMain {
    use std::string::String;
    // add companion struct to then be attached to the character.

    public struct Character has key {
        id: UID,
        adventures_name: String,
        adventures_level: u64,
        //companion: dragon struct
    } 
    public fun create_character(adventures_name: String, ctx: &mut TxContext) {
        let character = Character {
            id: object::new(ctx),
            adventures_name,
            adventures_level: 0,
        };
        transfer::transfer(character, tx_context::sender(ctx));
    }
   public fun generate_random(ctx: &mut TxContext): u64 {
    let hash_value: u64 = ctx.epoch() % 100; // Generate a pseudo-random number between 0-99
    hash_value // Return the hash_value, which is a u64
    }
}