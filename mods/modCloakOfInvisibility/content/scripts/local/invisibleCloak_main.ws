class CloakFX
{
	var isActive 	: bool;
	var cloakName 	: CName;
	
	
	public function init()
	{
		isActive = false;
		cloakName = 'Cloak of Invisibility';
	}
	
	
	public function getName() : CName
	{
		return cloakName;
	}


	public function handleCloak() : void
	{
		if (!isActive && checkIfCloakEquipped())
		{
			isActive = true;
			goInvisible();
		}
		else if ((isActive && !checkIfCloakEquipped()))
		{
			isActive = false;
			goVisible();
		}
	}
	
	
	function checkIfCloakEquipped() : bool
	{
		var i 		: int;
		var items 	: array<SItemUniqueId>;
		var inv 	: CInventoryComponent;
		
		inv = thePlayer.GetInventory();
		items = GetWitcherPlayer().GetEquippedItems();
		
		for (i = 0; i < items.Size(); i += 1)
		{
			if (inv.GetItemName(items[i]) == cloakName)
			{
				return true;
			}
		}
		
		return false;
	}
	

	function goInvisible() : void
	{	
		thePlayer.SetGameplayVisibility( false );
		thePlayer.SetTemporaryAttitudeGroup('neutral_to_player',3);
		
		thePlayer.BlockAction( EIAB_Jump, 'invisibleCloak' );
		thePlayer.BlockAction( EIAB_Sprint, 'invisibleCloak' );
		thePlayer.BlockAction( EIAB_Fists, 'invisibleCloak' );
		thePlayer.BlockAction( EIAB_SwordAttack, 'invisibleCloak' );
		thePlayer.BlockAction( EIAB_ThrowBomb, 'invisibleCloak' );
		thePlayer.BlockAction( EIAB_Signs, 'invisibleCloak' );
		thePlayer.BlockAction( EIAB_Crossbow, 'invisibleCloak' );
		thePlayer.BlockAction( EIAB_Interactions, 'invisibleCloak' );
		thePlayer.BlockAction( EIAB_MeditationWaiting, 'invisibleCloak' );
		
		EnableCatViewFx( 1.0f );	
		SetTintColorsCatViewFx(Vector(0.35f,0.35f,0.35f,0.3f),Vector(0.35f,0.35f,0.35f,0.3f), 0.8f);
		SetViewRangeCatViewFx(75.0f);
		SetFogDensityCatViewFx( 0.2f );
		SetBrightnessCatViewFx(10.0f);

		theSound.SoundEvent("magic_geralt_invisible_loop");	

		thePlayer.PlayEffect( 'invisible' );
	}


	function goVisible() : void
	{
		thePlayer.SetGameplayVisibility( true );
		thePlayer.ResetTemporaryAttitudeGroup(3);
		
		thePlayer.UnblockAction( EIAB_Jump, 'invisibleCloak' );
		thePlayer.UnblockAction( EIAB_Sprint, 'invisibleCloak' );
		thePlayer.UnblockAction( EIAB_Fists, 'invisibleCloak' );
		thePlayer.UnblockAction( EIAB_SwordAttack, 'invisibleCloak' );
		thePlayer.UnblockAction( EIAB_ThrowBomb, 'invisibleCloak' );
		thePlayer.UnblockAction( EIAB_Signs, 'invisibleCloak' );
		thePlayer.UnblockAction( EIAB_Crossbow, 'invisibleCloak' );
		thePlayer.UnblockAction( EIAB_Interactions, 'invisibleCloak' );
		thePlayer.UnblockAction( EIAB_MeditationWaiting, 'invisibleCloak' );
		
		DisableCatViewFx( 1.0f );
		
		theSound.SoundEvent("magic_geralt_invisible_loop_end");

		thePlayer.StopEffect( 'invisible' );
	}
};
