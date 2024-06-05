//Pre-build "terrain"
CbModelBegin();

var _ruleset = CbTilemapsToModelRuleset();
_ruleset.AddTileset(tsTiles).RemapEdgeAbove(1,0,   0,1, 1,0).RemapEdgeAbove(1,0,   0,1, 1,0);

var _array = ["Tiles_0", "Tiles_1", "Tiles_2", "Tiles_3"];

CbTilemapsToModel(_ruleset, _array, 0, 0, 0, 100, 100, 100);
CbLayerArrayHide(_array);
CbLayerArrayHide("Assets_1");

model = CbModelEnd();

//Define a handy draw function that we can call from oRenderer later
Draw = function()
{
    CbModelSubmit(model);    
    CbSpriteLayer("Assets_1");    
    CbSpriteExt(sprGuy,  0,    200, 400, 0,    2, 2, 0,  0,    c_white, 1, false);    
    CbBatchForceSubmit();
}