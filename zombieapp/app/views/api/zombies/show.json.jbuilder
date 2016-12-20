json.extract! @zombie, :id, :name
json.message I18n.t('zombie_message', name: @zombie.name)