var
	//Ability Help Topics and Descriptions

	text_eng = "This is your character's primary resource. Energy is used up with all your actions. The higher your energy, the more your character is able to do. The lower your energy, the less actions they can perform."

	text_str = "This is how strong your character is with melee attacks. The higher this stat, the harder you character will hit."

	text_end = "This helps to reduce the amount of damage your character takes when being hit in melee combat."

	text_agil = "This affects your attack speed in melee combat. The higher the stat, the faster your character can fight without pausing in between attacks."

	text_res = "This helps to reduce the amount of damage your character takes when being hit with psionic attacks."

	text_force = "This is how good your character is with psionic attacks. The higher this stat, the more damage your psionic attacks will do."

	text_acc = "This affects your offence in combat. The higher this stat, the more likely you are to hit your opponent with an attack in both melee and ranged combat."

	text_reflex = "This affects your chance to avoid or deflect an attack made against your character. The higher this stat, the more likely your character will be able to avoid incoming damage."

	text_vigour = "This is how well your body functions. It lowers when you get older and become frail and weak. Vigour is directly related to your power. If you have 100% vigour, you are at 100% Psionic Power. However, if you become old your vigour will start to decrease every month."

	text_recov = "This is how much energy your character recovers per second. The higher this stat, the quicker your character will return to full energy."

	text_energy_types = "The universe is teeming with different types of energy, each with its unique properties and abilities. At the heart of it all is pure energy, the fundamental force that underpins everything in existence. From this primordial energy, other forms of energy emerge through various processes.\

	When pure energy interacts with non-sentient beings or plants, it transforms into mana, a potent energy source that fuels spells and enchantments. However, when pure energy comes into contact with an intelligent creature, it undergoes a process known as psiforging, which transmutes it into psionic energy. This energy is incredibly powerful and is known to enhance cognitive abilities and grant telekinetic and telepathic powers.\

	If psionic energy is filtered through the lungs and into the dantian, the body's spiritual center, it becomes divine energy. This energy is imbued with the power of the divine and is capable of healing, purifying, and even resurrecting. The dantian acts as a furnace, refining and amplifying the divine energy for use.\

	Unfortunately, divine energy cannot last forever. Over time, it begins to fade, eventually devolving into dark matter, a form of energy that stagnates and contributes to the universe's entropy. It's believed that the fading of divine energy is due to the loss of the divine essence imbued within it.\

	The flow of energy is complex and can take various paths, but generally, it follows this sequence: pure energy > mana (non-sentient beings and plants) or psionic energy (intelligent creatures) > divine energy (through the dantian) > dark matter (after the loss of divine essence)."

	text_regen = "This is how much health your character regenerates per second. The higher this stat, the quicker your character will return to full health."

	text_bodysize_large = "Choosing a large bodysize will give +20% to your Strength, Endurance, Resistance and Regeneration stat mods. And -20% to your Force, Agility, Offence and Defence stat mods."
	text_bodysize_small = "Choosing a small bodysize will give +20% to your Force, Agility, Offence and Defence stat mods. And -20% to your Strength, Endurance, Resistance and Regeneration stat mods."
	text_bodysize_medium = "Choosing a medium bodysize gives no advantages or disadvantages to your characters stat mods."

	test_psiforging_lore = "Psiforging is the unique ability to forge ones own body parts into more powerful versions of themselves, strengthening bone density, muscle elasticity and organ functioning. Psionic power and energy are focused and combined into a cascading force that washes over the body part, wreathing it in incomprehensible intensity, creating preternatural results. Usually, this is done in a lotus position, with the user concentrating immensely on the task at hand. Via the power of the mind and the resultant Psionic forces that are produced under meditation, the Psiforging process can begin. First, chi energy is directed toward the dantian, collected into a sphere. This itself takes even the greatest master's years to perfect. Next, the Psionic offcast of powerful brain waves are directed toward the dantian too, mixing both to produce a new kind of potency. Finally, once the perfect balance is achieved and the right composition measured, the resultant forces can be directed like normal chi to any desired point within the body. Like the folding of steel, the energy is circulate carefully around the body part in great waves, amplifying and strengthening the part with each passing. The results usually vary based on the body part being worked on, but generally speaking, the outcome is always positive."

	text_yukopian = "Yukopians are plant-like beings that thrive on sunlight. They do not have bones like other races, but they are incredible with energy and very skilled and fast learners. \
	They live in an almost tribal-like society, with there always being an elder Yukopian to lead their people, usually the oldest and wisest of their numbers. \
	Yukopians live on a verdant paradise world named Yukopia, until a great flood washed over it. In response, a singular tree of gargantuan proportions named Mímameiðr, spent many long years sucking up all the water on the planet. \
	However, the world is now barren and devoid of moisture. It is up to the newly grown Yukopians to cultivate their world once more."

	text_yukopian_pros = "+ Can learn to regenerate from death \n\
	+ Faster skill levels \n\
	+ High energy multiplier \n\
	+ High defence multiplier \n\
	+ Long lifespan \n\
	+ 50% Toxic Tolerance \n\
	"

	text_yukopian_cons = "- No bones \n\
	- +50% extra heat damage \n\
	- +50% extra cold damage \n\
	"

	text_cerebroid = "The Cerebroid are intelligent on a level unlike anything seen before. Their technology borders on the arcane and their natural affinity for psionic power and genetic engineering \
	are unmatched. What they lack in physical strength and durability, they make up for with their psionic prowess and powers. However, something terrible happened to their people. Those that remain \
	are but clones, grown inside vats with no memory of their former lives. With little to no experience, those that remain must relearn everything from scratch and struggle to assert themselves \
	again as galatic contenders."

	text_cerebroid_pros = "+ Start with a Third Lobe \n\
	+ High intelligence multiplier \n\
	+ High energy multiplier \n\
	+ 50% Toxic Tolerance \n\
	"

	text_cerebroid_cons = "- Short lifespan \n\
	- Low endurance \n\
	- Slow gravity mastery \n\
	- Low environmental tolerance \n\
	"

	text_celestial = "The Celestials are beings of semi-divine nature, brought into creation by the pooling and saturation of mostly positive emotions and psionic forces that have coalesced in their realm. \
	They are a generally peaceful people, who strive for perfection in all things. But when roused to action, they can be uncompromisingly zealous in their divine retribution. Each of them has a \
	spark of the divine flowing through them, each manifested on the cusp of realizing this inner power. Many spend long centuries honing themselves to god-like status, cultivating their divine \
	energy into fully realized demonstrations of an ascended being."

	text_celestial_pros = "+ All Meditation gains +100%\n\
	+ Can grow bodyparts \n\
	+ Long lifespan \n\
	+ Cold tolerance\n\
	"

	text_celestial_cons = "- Start with no bodyparts\n\
	- Low endurance\n\
	- Slow ascension acquisition \n\
	- Trouble staying in mortal realm \n\
	"

	text_demon = "Vicious, malevolent and cunning psionic manifestations, spawned from the subconscious psyche of mortal minds. They are fear, rage and excess, pooled and coalesced \
	into creation. Perpetuated and fed by the suffering of others and the consumption of flesh, souls and psionic ectoplasmic expulsion. Hungry always for greater power, Demon are \
	cataclysmically strong. If not for the combined might of both the Celestial and Imp beings that inhabit their realm to keep them in check, the very balance of creation would \
	of shattered long ago."

	text_demon_pros = "+ Psiforging xp +100%\n\
	+ Can grow bodyparts \n\
	+ Long lifespan \n\
	+ Heat tolerance\n\
	"

	text_demon_cons = "- Start with no bodyparts\n\
	- Slow ascension acquisition \n\
	- Trouble staying in mortal realm \n\
	"

	text_imp = "The Imps are akin to custodians of the Psionic Realms. Like many of the spiritual inhabitants of that strange place, and its infinite cosmic energy, they are an enigma for the most part. \
	What is known, is many of them spend their time watching over not only their native realm, but all of creation, writing down in vast scrolls all that they see. They can be considered \
	lore keepers and chroniclers too, but primarily they try to keep balance in the Psionic Realms, for if left unchecked, Demons would run amok and Celestials would crusade and purge. Strangely, compared to the other races of the Psionic Realms, Imps appear to be made of flesh and blood."

	text_human_pros = "+ Master skills faster \n\
	+ High stat multipliers \n\
	+ Faster ascension acquisition \n\
	+ Can forge a Third Eye \n\
	"

	text_human_cons = "- Low Psionic power multiplier\n\
	- Short lifespan \n\
	- Slow gravity mastery \n\
	- Low environmental tolerance \n\
	"

	text_android = "At some indeterminate date, hidden in the annals of time, Humans on Earth managed to perfect their technological magnum opus. Hubris and Human nature would not abide two \
	powerful ideological forces inhabit the same world, and thus apocalyptic doom washed over the world. For a time, the Androids remained alone, frozen in the darkness of time, in the depths of \
	their technological tombs. Being entirely mechanical in nature, Androids struggle to grow thier powers in the same ways as other species do. Instead relying on upgrading  their bodyparts painstakingly \
	with suitable engineered parts. They also have very few origins to choose from compared to other races."

	text_android_pros = "+ High Psionic Power multiplier\n\
	+ High Energy multiplier \n\
	+ Heat, Cold, Toxic and Radiation immunity \n\
	+ Higher Gravity tolerance\n\
	+ Doesn't need oxygen \n\
	"

	text_android_cons = "- Low stat multipliers \n\
	- Generates radiation \n\
	- Lower Microwave radiation tolerance \n\
	- Relies on others to upgrade bodyparts \n\
	- Unable to increase lifespan \n\
	- Unable to eat most consumables \n\
	- Fewer origins to choose from \n\
	- No soul \n\
	"

	text_human = "Humans, they are a numerous species, with each individual varying greatly from one another. Their potential for raw psionic power is very limited, \
	perhaps being one of the weakest of any race in the universe. However, it should be noted that they more than make up for this with their much higher than average physical attributes. \
	Despite having less potency in their raw power, they excel in psi abilities, such as sensing others and using Energy based attacks. \
	Humans are intelligent people, allowing them to access some of the finest technologies available."

	text_meditation = "During meditation, you will recover your health and Energy at twice the normal rate. Using Meditation will increase and cultivate your stats, training your mind, body and soul. Forging each with great psionic power slowly over time."

	text_grabbing = "Grabbing allows you to manipulate and move objects and people around more easily than other means. You can let go of what you are holding by pressing E again. Double clicking anywhere with somehing held will throw the object or person toward where you clicked. How far the object travels when thrown is based on your strength. While holding an object, you gain Strength XP."

	//text_train = "During self training, you will gain strength and endurance, but gradually lose Energy from the strain. You can activate Self Training by left clicking. Right clicking it will bring up a series of options,  \
	//which allow you to set the focus of your training."

	text_flight = "Flight can be activated by clicking, but will consume a moderate amount of Energy per second. Gradually, your skill in flying will increase until there's hardly a drain on your resources. Right clicking will change the flight mode, allowing faster movement, but at the cost of more Energy."

	text_super_speed = "Toggling this skill on will allow you to double click any location and nearly instantly transvere to it, at the cost of Energy. As you become better in its use, the Energy cost will decrease and the chance it will trigger in melee will increase."

	text_focus = "Activating this ability will cause your character to focus intensely, increasing their stats and raw power by 10%. However, the strain is a constant drain on your Energy reserves. The higher your Recovery and Energy mods, the less this skill will drain you. Focus also increases the chances of lightning striking you during a thunderstorm, which is beneficial for your resistance stat."


	text_sense = "With this skill activated, you can get a general feel of the powers near you and the direction from which they orginiate. Anything stronger is always over 100% of your power and anything weaker is under 100%. This window will also display a comparison of stats for anyone you click, so long as you manage to hit your target."

	text_profusion = "Projects your inner force outward to increase your powers at the cost of draining your Energy slowly. With it active, your power, resistance and agility increase by 20%, and your force by 30%. However, the ability decreases your strength by 30% and your recovery by 20%, making it harder to recover or hurt others physically as easily."

	text_invisibility = "Using your psionic powers, you can slowly fade out of view and become almost entirely transparent. Higher levels of this technique will drain your Energy less, along with having high recovery and Energy mods."

	text_telekinesis = "This ability will allow you to produce amazing feats of skill with only your mind. With it, you can manipulate objects at the cost of your own Energy. Clicking the skill will toggle it on or off. Holding the left mouse button and dragging an object will force it to move, so long as you have enrgy to power the ability. You can also forcefully pull stuck and bolted objects out of the ground. Right clicking this skill will begin to train your force statistic and enter a minigame."

	text_divine_energy = "This type of special energy is derived from the Psionic Realms, a dimension connected to all points, at all times, everywhere. [css_divine]Divine Energy<font color = white> is incredibly precious, rare and hard to attain. Gods and mortals alike covet such a resource and both can manipulate it in various ways.\n\nMortals can use [css_divine]Divine Energy<font color = white> to infuse their bodies, minds and souls with great power, eventually using it to ascend to demigod status. Some beings are able to twist this energy into its polar opposite, creating [css_dark]Dark Matter<font color = white> in its stead."

	text_dark_matter = "[css_dark]Dark Matter<font color = white> is a fundamental force of the universe, an underlying swirling current or mass invisible to most beings senses. Unlike [css_divine]Divine Energy<font color = white>, its polar opposite, [css_dark]Dark Matter<font color = white> is more easily able to congeal and fuse with inanimate objects, due to it being electromagnetically dead.\n\nWhere as [css_divine]Divine Energy<font color = white> relies on an electromagnetic current to self-perpetuate and interface with living beings, [css_dark]Dark Matter<font color = white> can more easily fuse with machines, undead and ectoplasm. Many ascensions of a scientific or occult nature rely on [css_dark]Dark Matter<font color = white> as a means to attain greater power."

	//Tech Help Topics and Descriptions

	text_roleplay_points = "These offer a different way for players to progress in the game. They offer an opportunity to express creative writing and to become immersed in the game world. You can roleplay your character with others, or on your own, both are viable ways to supplement your character's growth."

	text_skill_points = "Nearly every stat you can raise has a Skill Point associated with it. For example, Strength has Strength Skill Points, and Energy has Energy Skill Points. Whenever you gain 10 levels in a stat, you gain a Skill Point. For example, if you level your Strength to 10, you will gain 1 Strength Skill Point for doing so. Skill Points can then be used to unlock skills related to the Skill Point in question. For example, Strength Skill Points could be used to unlock the Expand skill, but not the Flight skill. This is because the Expand skill is a Strength based skill which uses Strength Skill Points, and Flight is an Energy based skill which uses Energy Skill Points for its unlock."

	text_combat_levels = "This is the relative overall level of your character when all their combat stats are taken into consideration. Everytime you gain a level in a stat, your Combat Level xp raises. And every 10 times that happens, you gain a Combat Level. Every 10 Combat Levels, you gain 1 Trait Point to spend on Traits and Stances of your choice."

	text_trait_points = "Every 10 Combat Levels, you will gain a Trait Point. Trait Points can be spent on unlocking unique benefits that range from immediate advantages, to situational bonuses. Trait Points can also be used to unlock Stances."

	text_map = "Here you can find a visual representation of the various places in the game world. Some skills will require you to click a location on the map. For instance, teleportation will let you click a place on the map to travel to. You can even view other worlds and realms from here."

	text_underwater = "Entering water or another type of liquid, or other similar environmental area, causes your character to start gaining XP in Endurance and Psionic Power. Some races require oxygen to survive and running out will cause your character harm over time."

	text_bodypart_stats = "As you may know, bodyparts each have a specific stat increase associated with them. When that bodypart levels up, you also gain the listed stats. It is worth noting that the stats you gain from each bodypart upon leveling up, are actually enhanced by your stat multipliers. For example, if you have a 2 in your Strength multiplier, and the bodypart has a base Strength reward value of 1, you would gain 2 Strength. Where as a player with only a 1 in their Strength multiplier would only gain 1 Strength. The base value reward of each bodypart varies on which bodypart you choose to train, but generally speaking bones give Endurance and muscles give Strength."

	text_bodyparts = "The Body menu displays all the body parts contained within your character, from their very bones all the way to their skin. \
	\ Each part can be individually trained for stat increases, and even combined into Body Milestones that give even bigger bonuses. Generally, muscle parts give better Strength stats, bones give \
	\ better Endurance stats and organs tend to give many different attributes. As you gain xp toward a stat or a skills level, you also gain xp toward the bodypart you are training."

	text_death = "When your character dies, they usually goto the Psionic Realm, unless they have a means to avoid death. Death isn't permanent in Psiforged, but there are some drawbacks. While dead, you won't be effected by environmental means, but you also won't be able to gain benefits from training in them either. Since you don't have a body while dead, you will be unable to train and Psiforge your bodyparts. You will also not age. There are ways to return to life, mainly by using the Revivification skill."

	text_cybernetics = "Cybernetics are machine parts that interface and connect with organic bodyparts. Just like bodyparts, they have their own levels and stat rewards. You can view which cybernetics a bodypart has by clicking the Cybernetics tab, which displays after clicking a bodypart. Cybertech can be upgraded with a Mechanical Upgrade Kit. To add cybertech to a bodypart, click it while its in your inventory, then select a bodypart to apply it to. Keep in mind most cybertech can only be applied to certain bodyparts. Also, each bodypart has a limit on how many cybertech pieces can be applied. Cybernetics of the same type don't stack. When you die, all cybertech will be left at the location of your demise. You can also manually remove cybertech by right clicking it. Androids are unable to apply cybernetics to their bodyparts. Lastly, cybertech can't be fused with Divine Energy."

	text_gravity = "Gravity in Psiforged plays an important part to training your character. All gravity measurements are based on planet Earth, so 2 gravity in Psiforged refers to twice Earths gravity. Being in gravity thats higher than 1 will slowly raise your gravity mastery, but also cause you to take damage over time. Gravity mastery tells you how much gravity you can be inside without taking damage, and is also an indication to your progress and will also determine how much Psionic Power exp you will gain from all sources. A higher gravity mastery is desirable overall. Damage from gravity can be lowered from certain sources, such as having a well-trained spine or other quirk. The higher your gravity multiplier stat is for your race, the quicker you will master gravity. Gravity machines are always faster than natural phenomena such as black holes."

	tooltip_psionic_power = "Psionic Power Multiplier\n\n<font color=white>Most of your other statistics are multiplied by this number."
	tooltip_strength = "Strength\n\n<font color=white>This is how hard you hit in melee. It is countered by [css_endurance]Endurance<font color = white>."
	tooltip_endurance = "Endurance\n\n<font color=white>A higher [css_endurance]Endurance<font color = white> lets you take harder melee hits. It is countered by [css_strength]Strength<font color = white>."
	tooltip_agility = "Agility\n\n<font color=white>This effects how often your melee attacks go off. 20% of [css_agility]Agility<font color = white> is added to the [css_off]Offence<font color = white> and [css_def]Defence<font color = white> stats when determining dodge/deflect chances for melee and energy-based skills directed at you."
	tooltip_force = "Force\n\n<font color=white>Energy-based attacks use the [css_force]Force<font color = white> stat to determine damage. [css_resistance]Resistance<font color = white> counters [css_force]Force<font color = white>."
	tooltip_resistance = "Resistance\n\n<font color=white>This stat helps reduce the damage you take from energy-based attacks. [css_force]Force<font color = white> counters [css_resistance]Resistance<font color = white>."
	tooltip_energy = "Energy\n\n<font color=white>Many skills make use of [css_energy]Energy<font color = white> as a resource."
	tooltip_offence = "Offence\n\n<font color=white>This is how likely you are to hit someone with an attack versus their [css_def]Defence<font color = white>."
	tooltip_defence = "Defence\n\n<font color=white>This is how likely you are to avoid someones attacks. It is countered by [css_off]Offence<font color = white>."
	tooltip_recovery = "Recovery\n\n<font color=white>Having a higher [css_recov]Recovery<font color = white> stat determines how quickly you regain lost [css_energy]Energy<font color = white> and also how quickly you charge up energy-based attacks."
	tooltip_regen = "Regeneration\n\n<font color=white>This is how quickly you regain lost health and how quickly your bodyparts heal."
	tooltip_points = "Total Points\n\nThese are how many points you can spend on your statistics. You start with 10 to distribute to any of your stats except your [css_psionic_power]Psionic Power Multiplier<font color = white>."
	tooltip_tech = "This stat is perhaps the most singularly important attribute for someone wanting to focus on technology. It affects a whole range of aspects in regards to tech creation and research.\n\n[css_tech]Tech Potential<font color = white> represents a combination of many factors, such as character intelligence, species education, aptitude and inclination toward technology.\n\nGameplay-wise, [css_tech]Tech Potential<font color = white> is set when choosing a species and can be increased by Psiforging your brain and reading/using certain objects.\n\nHaving a higher [css_tech]Tech Potential<font color = white> reduces the cost and research times of technology."
	tooltip_secondary_stats = "Secondary Stats\n\nThese statistics are nearly as important to your character as their core stats, but have wide ranging effects on different aspects of gameplay and progression."
	tooltip_core_stats = "Core Stats\n\nThese stats are the most important in regards to combat. Each one is multiplied by the [css_psionic_power]Psionic Power<font color = white> multiplier, except for [css_regen]Regeneration<font color = white>, [css_recov]Recovery<font color = white> and [css_agility]Agility<font color = white>.\n\nAll core stats can be increased by training, especially when Psiforging."
	tooltip_combat_levels = "Combat Level\n\n<font color=white>This is the relative overall level of your character when all their core stats are taken into consideration.\n\nEverytime you gain a level in a stat outside of Psiforging, your [css_combat]Combat Level<font color = white> xp raises. And every 10 times that happens, you gain a [css_combat]Combat Level<font color = white>.\n\nEvery 10 [css_combat]Combat Level<font color = white>, you gain 1 Trait Point to spend on Traits and Stances of your choice."
	tooltip_stat_xp_bar = "Stat experience\n\nOnce this bar fills up and reaches the end, you will gain stats associated with this bar. Only experience earned outside Psiforging contributes to these bars filling.\n\nAll core stats when leveled this way give xp toward your combat level."
	tooltip_needs = "Needs\n\nYour needs are merely a representation of what most living beings require to survive, but in Psiforged, neglecting these doesn't result in death.\n\nHowever, having these low or high results in postive and negative changes to your core statistics."
	tooltip_oxygen = "Oxygen\n\nThis is how long you can hold your breath. It can be increased through various means, such as psiforging your lungs.\n\nHolding your breath too long results in penalties to your core statistics, but does not result in death.\n\nRunning out of oxygen while underwater can be a good way to train your character, but just remember to keep an eye on your health."
	tooltip_hunger = "Hunger\n\nHow hungry you are. The lower the hunger bar, the more hungry you become.\n\nWhen your hunger bar becomes empty, you begin to starve which results in penalties to your core statistics. However, this does not result in death.\n\nEating enough food and keeping this bar above 75% will grant a bonus to some of your core statistics."
	tooltip_thirst = "Thirst\n\nOver time, your character will desire water. The lower your thirst bar, the more thirsty you become.\n\nWhen your thirst bar becomes empty, you begin to dehydrate which results in penalties to your core statistics. However, this does not result in death.\n\nDrinking enough water and keeping this bar above 75% will grant a bonus to some of your core statistics."
	tooltip_sleep = "Tiredness\n\nThis is how rested your character is. The lower the tiredness bar, the more tired you become.\n\nWhen your tiredness bar becomes empty, you become exhausted which results in penalties to your core statistics. However, this does not result in death.\n\nSleeping enough and keeping this bar above 75% will grant a bonus to some of your core statistics."
	tooltip_tolerances = "Tolerances\n\nThese are a collection of environmental factors that your character is either resistant to, or weak against."
	tooltip_heat = "Heat\n\nThis is your characters heat tolerance and how well they can survive in hot environments.\n\nThe higher this is, the less damage you will take from sources of heat.\n\nHaving a heat tolerance of 100% means your character has immunity to lesser heat. When at or above 200%, it means you have perfect tolerance.\n\nThere are many ways to increase your tolerance, such as Psiforging your skin for instance.\n\nWhen in a hot environment, your core statistics suffer temporary penalties."
	tooltip_cold = "Cold\n\nThis is your characters cold tolerance and how well they can survive in cold environments.\n\nThe higher this is, the less damage you will take from sources of cold.\n\nHaving a cold tolerance of 100% means your character has immunity to lesser cold. When at or above 200%, it means you have perfect tolerance.\n\nThere are many ways to increase your tolerance, such as Psiforging your skin for instance.\n\nWhen in a cold environment, your core statistics suffer temporary penalties."
	tooltip_gravity = "Gravity\n\nThis is your characters gravity tolerance and how well they can survive in environments with higher gravity.\n\nThe higher this is, the less damage you will take from sources of high gravity.\n\nBeing in high gravity allows your character to gather [css_dark]Dark Matter<font color = white>.\n\nThere are many ways to increase your tolerance, such as Psiforging your spine for instance.\n\nWhen in a high gravity environment, your core statistics suffer temporary penalties."
	tooltip_microwaves = "Microwaves\n\nThis is your characters tolerance toward microwave energy and how well they can survive in environments with microwaves in.\n\nThe higher this is, the less damage you will take from sources of microwave energy.\n\nThere are many ways to increase your microwave energy tolerance, such as Psiforging your skin for instance.\n\nWhen in an environment with high microwave energy, your core statistics suffer temporary penalties."
	tooltip_radiation = "Radiation\n\nThis is your characters tolerance toward radiation and how well they can survive in environments with high levels of radiation.\n\nThe higher this is, the less damage you will take from sources of radiation.\n\nHaving a radiation tolerance of 100% means your character has immunity to lesser radiation. When at or above 200%, it means you have perfect tolerance.\n\nThere are many ways to increase your radiation tolerance, such as Psiforging your skin for instance.\n\nWhen in an environment with high radiation, your core statistics suffer temporary penalties."
	tooltip_toxins = "Toxins\n\nThis is your characters tolerance toward toxins and how fast you can recover from them.\n\nThe higher this is, the more Toxicity you will flush from your system per second. Your [css_regen]Regeneration<font color = white> mod also helps with this.\n\nWhen at or above 200%, it means you have perfect tolerance and can risk going over your Toxicity.\n\nThere are many ways to increase your toxin tolerance, such as Psiforging your liver for instance.\n\nWhen in an environment with high toxins or eating/drinking items that are toxic, your core statistics suffer temporary penalties and your toxicity will increase."
	tooltip_toxicity = "Toxicity\n\nThis is how much toxic material is in your system. When it is above 85% and you continue to accumulate more toxicity, certain body parts start to get damaged.\n\nToxic items you consume while you're above 85% toxicity gain double effects, but also damage certain body parts, lower your lifespan and give double toxicity buildup.\n\n<font color = red>Getting to 200% Toxicity will result in death!"
	tooltip_adaptations = "Adaptations\n\nThese are a number of different environmental situations that your character can become better at withstanding and master which in turn helps them become stronger."


obj
	help_topics
		icon = 'help_expand_buttons.dmi'
		icon_state = "expanded"
		maptext_width = 320
		maptext_height = 16
		plane = 35
		layer = 34
		blend_mode = BLEND_INSET_OVERLAY
		appearance_flags = KEEP_TOGETHER | TILE_BOUND | PIXEL_SCALE
		var/category
		var/displayed = 0
		/*
		Categories
			- Combat
			- Training
			- Environmental
			- Skills
			- Stats
			- Lore
			- Gameplay
			- Misc
			- Controls
			- GUI
		*/
		MouseEntered(object,location,control,params)
			src.icon_state = "expanded moused"
		MouseExited(location,control,params)
			src.icon_state = "expanded"
		MouseWheel(delta_x,delta_y,location,control,params)
			var/obj/hud/menus/help_background/s = usr.hud_help
			var/obj/sc = s.help_scroller

			usr.check_mouse_loc(params)
			var/true_y = ((usr.mouse_y-1)*32)+usr.mouse_pix_y
			usr.mouse_y_true = true_y
			var/wheel_move = 0
			if(delta_y > 0) wheel_move = 16
			else if(delta_y < 0) wheel_move = -16
			var/result = sc.translated_y+wheel_move
			result = clamp(result,0,-218)

			var/matrix/m = matrix()
			m.Translate(0,result)
			sc.transform = m
			sc.translated_y = result
			var/ratio = -1 + ((-218 + result) / -218)
			ratio = clamp(ratio,0,1)
			var/scroll_y = round(200*ratio)

			s.help_holder_y = scroll_y

			for(var/obj/txt in s.help_holder.vis_contents)
				var/matrix/m2 = matrix()
				m2.Translate(txt.hud_x,txt.hud_y+scroll_y)
				txt.transform = m2
		Click()
			if(src.type != /obj/help_topics/Alert_Misc)
				var/obj/hud/menus/help_background/s = usr.hud_help
				var/obj/hud/menus/help_background/txt_raw/txt = s.txt_raw
				txt.maptext = "[css_outline]<font size = 1><text align=center valign=top><u>[src.name]</u>\n<text align=left valign=top>[src.help_text]"
		Help_Energy_Types
			category = "lore"
			name = "Energy Types"
			New()
				help_text = text_energy_types
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Energy
			category = "stats"
			name = "Energy"
			New()
				help_text = text_eng
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Strength
			category = "stats"
			name = "Strength"
			New()
				help_text = text_str
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Endurance
			category = "stats"
			name = "Endurance"
			New()
				help_text = text_end
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Agility
			category = "stats"
			name = "Agility"
			New()
				help_text = text_agil
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Resistance
			category = "stats"
			name = "Resistance"
			New()
				help_text = text_res
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Offence
			category = "stats"
			name = "Offence"
			New()
				help_text = text_acc
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Force
			category = "stats"
			name = "Force"
			New()
				help_text = text_force
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Defence
			category = "stats"
			name = "Defence"
			New()
				help_text = text_reflex
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Recovery
			category = "stats"
			name = "Recovery"
			New()
				help_text = text_recov
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Regeneration
			category = "stats"
			name = "Regeneration"
			New()
				help_text = text_regen
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Trait_Points
			category = "training"
			name = "Trait Points"
			New()
				help_text = text_trait_points
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Meditation
			name = "Meditation"
			category = "skills"
			New()
				help_text = text_meditation
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Flight
			name = "Flight"
			category = "skills"
			New()
				help_text = text_flight
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Map
			name = "The Map"
			category = "gameplay"
			New()
				help_text = text_map
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Super_Speed
			name = "Super Speed"
			category = "skills"
			New()
				help_text = text_super_speed
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		/*
		Help_Telekinesis_Minigame
			name = "Telekinesis Minigame"
			New()
				help_text = text_telekinesis_minigame
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		*/
		Help_Cybernetics
			name = "Cybernetics"
			category = "gameplay"
			New()
				help_text = text_cybernetics
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Grabbing
			name = "Grabbing"
			category = "gameplay"
			New()
				help_text = text_grabbing
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Dark_Matter
			name = "Dark Matter"
			category = "stats"
			New()
				help_text = text_dark_matter
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		/*
		Help_Lightning
			name = "Lightning"
			New()
				help_text = text_lightning
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		*/
		Help_Bodypart_Stats
			name = "Bodypart Stats"
			category = "stats"
			New()
				help_text = text_bodypart_stats
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Bodyparts
			name = "Bodyparts"
			category = "gameplay"
			New()
				help_text = text_bodyparts
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Underwater
			name = "Underwater"
			category = "training"
			New()
				help_text = text_underwater
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Focus
			name = "Focus"
			category = "skills"
			New()
				help_text = text_focus
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Death
			name = "Death"
			category = "gameplay"
			New()
				help_text = text_death
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Divine_Energy
			name = "Divine Energy"
			category = "stats"
			New()
				help_text = text_divine_energy
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Skill_Points
			name = "Skill Points"
			category = "training"
			New()
				help_text = text_skill_points
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Combat_Levels
			name = "Combat Levels"
			category = "training"
			New()
				help_text = text_combat_levels
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Alert_Misc
			name = "Alert"
			New()
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Vigour
			name = "Vigour"
			category = "gameplay"
			New()
				help_text = text_vigour
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel
		Help_Gravity
			name = "Gravity"
			category = "environmental"
			New()
				help_text = text_gravity
				var/image/sel = image('fx.dmi',src,"select item",1000)
				src.img_select = sel