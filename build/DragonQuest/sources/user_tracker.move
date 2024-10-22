module DragonQuest::user_tracker {
    use sui::table::{Table, new, add, contains}; // borrow?

    // Initialize the table for tracking user statuses
    public struct UserStatusTable has store {
        status: Table<address, bool>,
    }

    // Create a new UserStatusTable
    public fun create_user_status_table(ctx: &mut TxContext): UserStatusTable {
        UserStatusTable {
            status: new<address, bool>(ctx),
        }
    }

    // Check if a user has created a character
    public fun check_user_status(user_status_table: &UserStatusTable, user_address: address): bool {
        contains(&user_status_table.status, user_address)
    }

    // Add a user status indicating a character has been created
    public fun mark_character_created(user_status_table: &mut UserStatusTable, user_address: address) {
        add(&mut user_status_table.status, user_address, true);
    }
}
