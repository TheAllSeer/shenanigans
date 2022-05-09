create table Characters 
(character_id int not null,
char_name nvarchar(100) not null,
class_id int not null,
spec_id int,
covenant_id int,
faction_id int not null,
gender_id int not null,
race_id int not null,
twos int,
threes int,
rbgs int,
raider_io int,
creation_date date,
constraint pk_character_id primary key (character_id)
)

alter table Characters add constraint fk_spec_id foreign key(spec_id) references Specs(spec_id)
alter table Characters add constraint fk_class_id foreign key(class_id) references Classes(class_id)
alter table Characters add constraint fk_covenant_id foreign key(covenant_id) references Covenants(covenant_id)
alter table Characters add constraint fk_faction_id foreign key(faction_id) references Factions(faction_id)
alter table Characters add constraint fk_gender_id foreign key(gender_id) references Genders(gender_id)
alter table Characters add constraint fk_race_id foreign key(race_id) references Races(race_id)



create table Classes
(
class_id int not null,
class_name nvarchar(100) not null,
constraint pk_class_id primary key (class_id)
)


create table Specs
(
spec_id int not null,
spec_name nvarchar(100) not null,
class_name nvarchar(100) not null,
role_id int not null,
constraint pk_spec_id primary key (spec_id)
)
alter table Specs add constraint fk_class_id2 foreign key(class_id) references Classes(class_id)
alter table Specs add constraint fk_role_id foreign key(role_id) references Roles(role_id)

create table Factions
(
faction_id int not null,
faction_name nvarchar(100),
constraint pk_faction_id primary key(faction_id)
)

create table Genders
(
gender_id int not null,
gender_name nvarchar(100),
constraint pk_gender_id primary key(gender_id)
)

create table Covenants
(
covenant_id int not null,
cov_name nvarchar(100),
constraint pk_cov_id primary key(covenant_id)
)

create table Races
(
race_id int not null,
faction_id int not null,
race_name nvarchar(100) not null,
constraint pk_race_id primary key (race_id)
)

alter table Races add constraint fk_faction_id2 foreign key(faction_id) references Factions(faction_id)


create table Roles
(
role_id int not null,
role_name nvarchar(100) not null
constraint pk_role_id primary key(role_id) 
)


----------------------------------------------------------------- inserting information

insert into Classes  --classes
values 
(1, 'Death Knight'),
(2, 'Demon Hunter'),
(3, 'Druid'),
(4, 'Hunter'),
(5, 'Mage'),
(6, 'Monk'),
(7, 'Paladin'),
(8, 'Priest'),
(9, 'Rogue'),
(10, 'Shaman'),
(11, 'Warlock'),
(12, 'Warrior')



insert into Covenants --covenants
values 
(1, 'Night Fae'),
(2, 'Kyrian'),
(3, 'Necrolord'),
(4, 'Venthyr')


insert into Factions --factions

values
(1, 'Horde'),
(2, 'Alliance')

insert into Genders --genders

values
(1, 'Male'),
(2, 'Female')

insert into Races --races
values 
(1, 1, 'Blood Elf'),
(2, 1, 'Orc'),
(3, 2, 'Kul Tiran'),
(4, 1, 'Highmountain Tauren'),
(5, 1, 'Troll'),
(6, 1, 'Zandalari Troll'),
(7, 2, 'Worgen'),
(8, 1, 'Vulpera'),
(9, 2, 'Mechagnome'),
(10, 2, 'Night Elf'),
(11, 2, 'Human'),
(12, 1, 'Goblin'),
(13, 1, 'Nightborne Elf'),
(14, 2, 'Dwarf'),
(15, 1, 'Undead'),
(16, 1, 'Tauren'),
(17, 2, 'Void Elf'),
(18, 2, 'Dark Iron Dwarf'),
(19, 1, 'Maghar Orc'),
(20, 2, 'Gnome'),
(21, 2, 'Draenei'),
(22, 2, 'Lightforged Draenei'),
(23, 1, 'Pandarean'),
(24, 2, 'Pandarean')


insert into Roles --roles
values
(1, 'DPS'),
(2, 'Healer'),
(3, 'Tank')


select * from Classes
select * from Specs
update Classes --updating because I had Monk twice, one on #2 instead of demon hunter and one in #6
set
class_name = 'Demon Hunter'
where class_id = 2

insert into Specs --specs
values
--dk
(1, 'Blood', 1, 3),
(2, 'Frost', 1, 1),
(3, 'Unholy', 1, 1),
--dh
(4, 'Vengeance', 2, 3),
(5, 'Havoc', 2, 1),
--druid
(6, 'Balance', 3, 1),
(7, 'Feral', 3, 1), 
(8, 'Guardian', 3, 3),
(9, 'Restoration', 3, 2),
--hunter
(10, 'Marksmanship', 4, 1),
(11, 'Beast Mastery', 4, 1),
(12, 'Survival', 4, 1),
--mage
(13, 'Frost', 5, 1),
(14, 'Fire', 5, 1),
(15, 'Arcane', 5, 1),
--monk
(16, 'Brewmaster', 6, 3), 
(17, 'Mistweaver', 6, 2),
(18, 'Windwalker', 6, 1),
--pala
(19, 'Retribution', 7, 1),
(20, 'Holy', 7, 2),
(21, 'Protection', 7, 3),
--priest
(22, 'Shadow', 8, 1),
(23, 'Holy', 8, 2),
(24, 'Discipline', 8, 2),
--rogue
(25, 'Subtlety', 9, 1), 
(26, 'Assassination', 9, 1), 
(27, 'Outlaw', 9, 1), 
--sham
(28, 'Enhancement', 10, 1),
(29, 'Elemental', 10, 1), 
(30, 'Restoration', 10, 2), 
--lock
(31, 'Affliction', 11, 1), 
(32, 'Destruction', 11, 1), 
(33, 'Demonology', 11, 1), 
--GOD CLASS BEST CLASS 
(34, 'Arms', 12, 1), 
(35, 'Fury', 12, 1), 
(36, 'Protection', 12, 3)


