#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

// Define the game data structure
struct Game {
    map<string, int> variables;
    vector<string> code;
};

// Define the compiler functions
Game compile(const string& filename) {
    Game game;
    ifstream file(filename);
    string line;

    // Read the game script
    while (getline(file, line)) {
        // Split the line into tokens
        vector<string> tokens;
        size_t start = 0;
        while ((start = line.find(' ')) != string::npos) {
            tokens.push_back(line.substr(0, start));
            line.erase(0, start + 1);
        }
        tokens.push_back(line);

        // Process the tokens
        for (const string& token : tokens) {
            // Check for variable assignments
            if (token.find('=') != string::npos) {
                size_t equal = token.find('=');
                string variable = token.substr(0, equal);
                string value = token.substr(equal + 1);
                game.variables[variable] = stoi(value);
            }
            // Check for game logic
            else if (token == "if") {
                // Read the condition
                string condition;
                getline(file, condition);
                // Read the code
                vector<string> code;
                while (getline(file, line) && line.find("endif") == string::npos) {
                    code.push_back(line);
                }
                // Add the code to the game
                game.code.insert(game.code.end(), code.begin(), code.end());
            }
            // Check for game logic
            else if (token == "while") {
                // Read the condition
                string condition;
                getline(file, condition);
                // Read the code
                vector<string> code;
                while (getline(file, line) && line.find("endwhile") == string::npos) {
                    code.push_back(line);
                }
                // Add the code to the game
                game.code.insert(game.code.end(), code.begin(), code.end());
            }
        }
    }

    return game;
}

// Define the game runner
void run(const Game& game) {
    // Initialize the game variables
    for (const auto& variable : game.variables) {
        cout << variable.first << " = " << variable.second << endl;
    }

    // Run the game code
    for (const string& line : game.code) {
        cout << line << endl;
    }
}

int main() {
    // Compile the game script
    Game game = compile("game.txt");

    // Run the game
    run(game);

    return 0;
}
