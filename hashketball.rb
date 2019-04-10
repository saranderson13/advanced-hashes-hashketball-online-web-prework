require 'pry'

def game_hash
  # returns a nested hash of game information
  
  game_hash = {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black", "White"],
      players: {
        "Alan Anderson" => {
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        },
        "Reggie Evans" => {
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        },
        "Brook Lopez" => {
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        },
        "Mason Plumlee" => {
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 12,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        },
        "Jason Terry" => {
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      }
    },
    
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: {
        "Jeff Adrien" => {
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2
        },
        "Bismak Biyombo" => {
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 7,
          blocks: 15,
          slam_dunks: 10
        },
        "DeSagna Diop" => {
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        },
        "Ben Gordon" => {
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        },
        "Brendan Haywood" => {
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 22,
          blocks: 5,
          slam_dunks: 12
        }
      }
    }
  }
end

def num_points_scored(player_name)
  # returns the number of points scored by a player
  
  game_hash.each do |home_away, team_info|
    team_info[:players].each { |player, stats|  return stats[:points] if player == player_name }
  end
end


def shoe_size(player_name)
  # returns the shoe size of a player
  
  game_hash.each do |home_away, team_info|
    team_info[:players].each { |player, stats| return stats[:shoe] if player == player_name }
  end
end


def team_colors(team_name)
  # returns an array with the team colors
  
  game_hash.each { |home_away, team_info| return team_info[:colors] if team_info[:team_name] == team_name }
end

def team_names
  # returns an array with both team names

  game_hash.collect { |home_away, team_info| team_info[:team_name] }
end


def player_numbers(team_name)
  # returns an array of all jersey numbers for a team
  jersey_numbers = []
  
  game_hash.each do |home_away, team_info|
    return team_info[:players].map { |player, stats| stats[:number] } if team_info[:team_name] == team_name
  end
end


def player_stats(player_name)
  # returns a hash of the player's stats
  game_hash.each do |home_away, team_info|
    team_info[:players].each { |name, stats| return stats if name == player_name }
  end
end

def big_shoe_rebounds
  # returns the number of rebounds of the player with the biggest shoe size
  rebounders = { shoe: 0, rebounds: 0 }
  
  game_hash.each do |home_away, team_info|
    team_info[:players].each do |player, stats|
      if stats[:shoe] > rebounders[:shoe] 
        rebounders[:shoe] = stats[:shoe]
        rebounders[:rebounds] = stats[:rebounds]
      end
    end
  end
  rebounders[:rebounds]
end

# BONUS METHODS!

def most_points_scored
  # returns the name of the player with the most points
  highest_scorer = { player: "", points: 0 }
  
  game_hash.each do |home_away, team_stats|
    team_stats[:players].each do |player, stats|
      if stats[:points] > highest_scorer[:points]
        highest_scorer[:player] = player
        highest_scorer[:points] = stats[:points]
      end
    end
  end
  highest_scorer[:player]
end

def winning_team
  # returns the team with the most points
  team_scores = { 
    home: {
      name: "",
      points: [],
      total: 0
    },
    away: {
      name: "",
      points: [],
      total: 0
    }
  }
  
  game_hash.each do |home_away, team_info|
    if home_away == :home
      team_scores[:home][:name] = team_info[:team_name]
      team_info[:players].each do |player, stats|
        team_scores[:home][:points] << stats[:points]
      end
    elsif home_away == :away
      team_scores[:away][:name] = team_info[:team_name]
      team_info[:players].each do |player, stats|
        team_scores[:away][:points] << stats[:points]
      end
    end
  end
  
  team_scores[:home][:points].each { |player_points| team_scores[:home][:total] += player_points }
  team_scores[:away][:points].each { |player_points| team_scores[:away][:total] += player_points }
  
  team_scores[:home][:total] > team_scores[:away][:total] ? team_scores[:home][:name] : team_scores[:away][:name]
end


def player_with_longest_name
  # returns the player with the longest name
  longest_name = ""
  
  game_hash.each do |home_away, team_stats|
    team_stats[:players].each { |player, stats| longest_name = player if player.length > longest_name.length }
  end
  
  longest_name
end


# SUPER BONUS!!

def long_name_steals_a_ton?
  # returns true if the player with the longest name has the most steals
  
  player_to_beat = { name: player_with_longest_name, steals: 0 }
  
  game_hash.each do |home_away, team_stats|
    team_stats[:players].each do |player, stats|
      player_to_beat[:steals] = stats[:steals] if player == player_to_beat[:name]
    end
  end
  
  more_steals = []
  
  game_hash.each do |home_away, team_stats|
    team_stats[:players].each do |player, stats|
      if player != player_to_beat[:name]
        more_steals << player if player_to_beat[:steals] < stats[:steals]
      end
    end
  end
  more_steals.length == 0 ? true : false
end
