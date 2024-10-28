module DragonQuest::BalanceManager {

    public struct Random_number has key {
        id: UID
    }

    public entry fun generate_number_for_rarity(ctx: &mut TxContext): u8 {
        let new_id = object::new(ctx);
        let id_to_bytes = object::uid_to_bytes(&new_id);
        let bytes:u8 = id_to_bytes[0];
        let number:u8 = bytes % 100;
        let random_number = Random_number {
            id: new_id
        };
        let Random_number {
            id
        } = random_number ;
        object::delete(id);
        number
    }
    public entry fun generate_number_for_nature(ctx: &mut TxContext): u8 {
        let new_id = object::new(ctx);
        let id_to_bytes = object::uid_to_bytes(&new_id);
        let bytes:u8 = id_to_bytes[0];
        let number:u8 = bytes % 4; // numbers in between 1-4?
        let random_number = Random_number {
            id: new_id
        };
        let Random_number {
            id
        } = random_number ;
        object::delete(id);
        number
    }
    public entry fun generate_number_for_larger(ctx: &mut TxContext): u64 {
        let new_id = object::new(ctx);
        let id_to_bytes = object::uid_to_bytes(&new_id);
        let bytes:u64 = id_to_bytes[0] as u64;
        let number:u64 = bytes * bytes % 1000; // numbers in between 1-4?
        let random_number = Random_number {
            id: new_id
        };
        let Random_number {
            id
        } = random_number ;
        object::delete(id);
        number
    }
}