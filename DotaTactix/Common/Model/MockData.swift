//
//  MockData.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import Foundation

enum MockData {
  static let hero = Hero(from: heroData, abilities: [ability], talents: [talent1, talent2])
  static let ability = Ability(slot: 1, ability: abilityData)
  static let talent1 = Talent(slot: 1, ability: abilityData)
  static let talent2 = Talent(slot: 2, ability: abilityData)
  static let tactics = Tactics(
    itemBuild: ItemBuild(
      startingItems: ["Null Talisman", "Iron Branch", "Tango", "Healing Salve"],
      earlyGame: ["Boots of Speed", "Hand of Midas", "Magic Wand"],
      coreItems: ["Aghanim\'s Scepter", "Eul\'s Scepter of Divinity", "Blink Dagger"],
      luxuryItems: ["Scythe of Vyse", "Octarine Core", "Refresher Orb"],
      situationalItems: ["Black King Bar", "Linken\'s Sphere", "Shiva\'s Guard"]),
    strategy: Strategy(
      earlyGame: """
      Focus on last hitting and denying to gain experience and gold.
      Use abilities to harass and secure range last hits.
      Look for opportunities to rotate and gank side lanes with Sun Strike.
      """,
      midGame: """
      Participate in team fights and ganks with EMP-Tornado combo, and use Ice Wall and Meteor to control team fights.
      Push lanes and create space for the team. Complete core items and look for pick-offs.
      """,
      lateGame: """
      Be the primary damage dealer in team fights, invoking the appropriate spells and combos based on the situation.
      Use Cataclysm and combo spells to burst down enemies.
      Position well and look for opportunities to initiate with your team.
      """))

  static let heroAbilities = [
    HeroAbilityData(slot: 1, abilityID: 1001),
    HeroAbilityData(slot: 2, abilityID: 1002)
  ]

  static let heroRoles = [
    Role(roleID: 0),
    Role(roleID: 1)
  ]

  static let heroTalents = [
    TalentData(slot: 0, abilityID: 2001),
    TalentData(slot: 1, abilityID: 2002)
    // Add more talents as needed
  ]

  static let heroStat = StatData(
    attackType: .melee,
    startingArmor: 5.0,
    startingMagicArmor: 10,
    startingDamageMin: 30,
    startingDamageMax: 35,
    attackRate: 1.5,
    attackRange: 150,
    attributePrimary: .agi,
    strengthBase: 20,
    strengthGain: 2.0,
    intelligenceBase: 15,
    intelligenceGain: 1.5,
    agilityBase: 25,
    agilityGain: 3.0,
    hpRegen: 2.5,
    mpRegen: 1.0,
    moveSpeed: 310,
    moveTurnRate: 0.6,
    visionDaytimeRange: 1800,
    visionNighttimeRange: 800,
    complexity: 2)

  static let heroData = HeroData(
    id: 1,
    name: "npc_dota_hero_antimage",
    displayName: "Anti-Mage",
    shortName: "antimage",
    abilities: heroAbilities,
    roles: heroRoles,
    talents: heroTalents,
    stat: heroStat,
    language: Language(bio: "Some bio text here", hype: "Some hype text here"))

  static let abilityData = AbilityData(
    dname: "Mana Break",
    attrib: [
      Attrib(
        key: "percent_damage_per_burn",
        header: "MANA BURNED AS DAMAGE:",
        value: CD.string("50%"),
        generated: nil,
        footer: nil),
      Attrib(
        key: "mana_per_hit",
        header: "MANA BURNED PER HIT:",
        value: CD.stringArray(["25", "30", "35", "40"]),
        generated: nil,
        footer: nil),
      Attrib(
        key: "mana_per_hit_pct",
        header: "MAX MANA BURNED PER HIT:",
        value: CD.stringArray(["1.6%", "2.4%", "3.2%", "4%"]),
        generated: nil,
        footer: nil),
      Attrib(
        key: "illusion_percentage",
        header: "ILLUSION PERCENTAGE:",
        value: CD.string("50"),
        generated: true,
        footer: nil),
      Attrib(
        key: "move_slow",
        header: "MOVE SPEED SLOW ON FULL DRAIN:",
        value: CD.stringArray(["25%", "30%", "35%", "40%"]),
        generated: nil,
        footer: nil),
      Attrib(
        key: "slow_duration",
        header: "SLOW DURATION:",
        value: CD.string("0.75"),
        generated: nil,
        footer: nil)
    ],
    img: "/apps/dota2/images/dota_react/abilities/antimage_mana_break.png",
    behavior: BehaviorUnion.enumeration(BehaviorElement.passive),
    targetTeam: .enumArray([.enemy]),
    dmgType: DmgTypeUnion.enumeration(DmgTypeEnum.physical),
    bkbpierce: BkbpierceUnion.enumeration(BkbpierceEnum.no),
    desc: """
    Burns an opponent's mana on each attack and deals damage equal to a percentage of the mana burnt.
    Enemies with no mana left are temporarily slowed.
    """,
    lore: "A modified technique of the Turstarkuri monks' peaceful ways is to turn magical energies on their owner.",
    manacost: CD.string("45"),
    cooldown: CD.stringArray(["13.5", "11", "8.5", "6"]),
    dispellable: BkbpierceUnion.enumeration(BkbpierceEnum.yes),
    targetType: .enumArray([TargetTypeElement.building, TargetTypeElement.tree]),
    dmg: CD.string("50"))
}
