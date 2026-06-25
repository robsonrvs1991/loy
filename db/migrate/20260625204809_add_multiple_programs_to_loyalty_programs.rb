class AddMultipleProgramsToLoyaltyPrograms < ActiveRecord::Migration[8.1]
  def change
    add_column :loyalty_programs, :name, :string
    add_reference :loyalty_programs, :service, foreign_key: true, null: true
    add_column :loyalty_programs, :active, :boolean, default: true, null: false

    add_reference :rewards, :loyalty_program, foreign_key: true, null: true

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE loyalty_programs
          SET name = 'Programa de fidelidade'
          WHERE name IS NULL OR name = '';
        SQL

        execute <<~SQL
          UPDATE rewards r
          SET loyalty_program_id = lp.id
          FROM loyalty_programs lp
          WHERE r.barbershop_id = lp.barbershop_id
            AND r.loyalty_program_id IS NULL
            AND lp.id = (
              SELECT lp2.id
              FROM loyalty_programs lp2
              WHERE lp2.barbershop_id = r.barbershop_id
              ORDER BY lp2.id ASC
              LIMIT 1
            );
        SQL
      end
    end
  end
end