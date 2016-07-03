local Board = require("Board")
local Cell = require("Cell")
local State = require("State")
local MooreTown = require("MooreTown")
local VonNeumannTown = require("VonNeumannTown")
local TownKeyGenSum = require("TownKeyGenSum")

local CA = {}

CA.Board = Board
CA.Cell = Cell
CA.State = State
CA.MooreTown = MooreTown
CA.VonNeumannTown = VonNeumannTown
CA.TownKeyGenSum = TownKeyGenSum

return CA
