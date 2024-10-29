#[test_only]
module DragonQuest::test {
    use std::string::{String};
    use sui::test_scenario;
    use std::string;

    use sui::tx_context;
    use DragonQuest::DragonQuestMain::{
        create_character, 
        get_dragon_egg, 
        gain_experience,
        enter_cave,
        exit_cave,
        Character };
        
    use DragonQuest::BalanceManager::{generate_number_for_rarity,
        generate_number_for_nature,
        generate_number_for_larger };

   /// Helper to run randomized tests N times (fuzz-style).
    fun fuzz_test_generate_number_for_rarity(fuzz_runs: u64) {
        let mut ctx = tx_context::dummy();

        // Run the test for 'iterations' times to simulate fuzzing
        let mut i = 0;
        while (i < fuzz_runs) {
            let rarity = generate_number_for_rarity(&mut ctx);

            // Check if rarity is within a valid range
            assert!(rarity >= 0 && rarity < 101, 0); // Example range [1,10]
            i = i + 1;
        }
    }

    fun test_generate_number_for_nature(fuzz_runs: u64) {
        let mut ctx = tx_context::dummy();

        let mut i = 0;
        while (i < fuzz_runs) {
            let nature = generate_number_for_nature(&mut ctx);
            assert!(nature >= 0 && nature <5, 1); // expected to go to zero but not expected to be larger then the highest number.
            i = i + 1
        }
    }

    fun test_generate_number_for_larger(fuzz_runs: u64) {
        let mut ctx = tx_context::dummy();

        let mut i = 0;
        while(i < fuzz_runs) {
            let large_number = generate_number_for_larger(&mut ctx);

            assert!(large_number >= 0 && large_number < 1000, 2);
            i = i + 1;
        }
    }

    #[test]
    public fun fuzz_test_random_number_functions() {
        // Fuzz the test 100 times
        fuzz_test_generate_number_for_rarity(1000);
        test_generate_number_for_nature(1000);
        test_generate_number_for_larger(1000);
    }

    #[test]
    public fun test_create_character() {
        let mut ctx = tx_context::dummy();
        let name = string::utf8(b"character");

        create_character(name, &mut ctx); 
        let owner = tx_context::sender(&ctx);
        let character_object_address = tx_context::last_created_object_id(&ctx);

        assert!(character_object_address != @0x0, 3)

    }

}