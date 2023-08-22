class SeedGolfers < ActiveRecord::Migration[7.0]
  def up
    Golfer.create([
      { name: "Joey Chestnut", gamertag: "zsspanther" },
      { name: "Bobby Flay", gamertag: "TheRev33" },
      { name: "Corporal Creampie", gamertag: "CPMC19" },
      { name: "Ched OneTime", gamertag: "CheddaOneTime" },
      { name: "George Strait", gamertag: "*****SNOWTA409" },
      { name: "Glen Griffey Jr.", gamertag: "DjQ405" },
      { name: "Frederick Cedric", gamertag: "T Dubble08" },
      { name: "G-Money", gamertag: "ShUfFlEmAcHiNe" },
      { name: "Superintendent Gateley", gamertag: "Boomer11Sooner" },
      { name: "I guess just Ethan", gamertag: "RICH723" },
    ])
  end

  def down
    Golfer.destroy_all
  end
end
