//
//  SkillStatsView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct SkillStatsView: View {
  let skill: Ability

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      // MARK: - Ability

      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 2) {
          if case .enumArray(let behaviors) = skill.ability.behavior {
            if !behaviors.isEmpty {
              SkillDescriptionView(title: "ABILITY: ", data: "\(behaviors[0].rawValue)")
            }
          } else if case .enumeration(let behavior) = skill.ability.behavior {
            SkillDescriptionView(title: "ABILITY: ", data: "\(behavior.rawValue)")
          }

          if case .enumArray(let targets) = skill.ability.targetTeam {
            HStack(spacing: 0) {
              Text("AFFECTS: ")
                .regularFont(size: 13, color: .gray)
              ForEach(targets, id: \.self) { target in
                Text("\(target.rawValue) Units")
                  .regularFont(size: 13)
              }
            }
          } else if case .enumeration(let target) = skill.ability.targetTeam {
            SkillDescriptionView(title: "AFFECTS: ", data: "\(target.rawValue)")
          }

          if case .enumeration(let dmgType) = skill.ability.dmgType {
            SkillDescriptionView(
              title: "DAMAGE TYPE: ",
              data: "\(dmgType.rawValue)",
              dataColor: dmgType == .physical ? .red
                : dmgType == .magical ? .blue
                : dmgType == .pure ? .orange
                : .white
            )
          }
        }

        Spacer()

        VStack(alignment: .leading, spacing: 2) {
          if case .enumeration(let bkbPierce) = skill.ability.bkbpierce {
            SkillDescriptionView(title: "PIERCES SPELL IMMUNITY: ", data: "\(bkbPierce.rawValue)")
          }

          if case .enumeration(let dispellable) = skill.ability.dispellable {
            SkillDescriptionView(title: "DISPELLABLE: ", data: "\(dispellable.rawValue)")
          }
        }
      }

      // MARK: - Attributes

      VStack(alignment: .leading, spacing: 2) {
        ForEach(skill.ability.attrib ?? [], id: \.key) { attrib in
          HStack {
            Text(attrib.header)
              .regularFont(size: 13, color: .gray)

            if case .stringArray(let attribs) = attrib.value {
              HStack(spacing: 0) {
                ForEach(Array(attribs.enumerated()), id: \.0) { index, attrib in
                  Text("\(attrib)\(index < attribs.count - 1 ? " / " : "")")
                    .regularFont(size: 13)
                }
              }
            } else if case .string(let attrib) = attrib.value {
              Text("\(attrib)")
                .regularFont(size: 13)
            }
          }
        }
      }

      // MARK: - Cooldown, Manacost

      HStack {
        if case .stringArray(let cooldowns) = skill.ability.cooldown {
          HStack(spacing: 0) {
            Image(.cooldown)
              .cornerRadius(3)
              .padding(.trailing, 5)
            ForEach(Array(cooldowns.enumerated()), id: \.0) { index, cooldown in
              Text("\(cooldown)\(index < cooldowns.count - 1 ? " / " : "")")
                .regularFont(size: 13)
            }
          }
        } else if case .string(let cooldown) = skill.ability.cooldown {
          HStack {
            Image(.cooldown)
              .cornerRadius(3)
            Text("\(cooldown)")
              .regularFont(size: 13)
          }
        }

        Spacer()

        if case .stringArray(let manas) = skill.ability.manacost {
          HStack(spacing: 0) {
            Color.blue
              .saturation(5)
              .frame(width: 16, height: 16)
              .cornerRadius(3)
              .padding(.trailing, 5)
            ForEach(Array(manas.enumerated()), id: \.0) { index, mana in
              Text("\(mana)\(index < manas.count - 1 ? " / " : "")")
                .regularFont(size: 13)
            }
          }
        } else if case .string(let mana) = skill.ability.manacost {
          HStack {
            Color.blue
              .saturation(5)
              .frame(width: 16, height: 16)
              .cornerRadius(3)
            Text("\(mana)")
              .regularFont(size: 13)
          }
        }
      }

      // MARK: - Lore

      if let lore = skill.ability.lore, !lore.isEmpty {
        Text(lore)
          .boldFont(size: 12, color: .gray)
          .padding(10)
          .frame(maxWidth: .infinity)
          .background(.grayDark)
          .multilineTextAlignment(.leading)
      }
    }
    .padding(10)
    .background(.black)
    .cornerRadius(5)
  }
}
