start-ansible:
	docker compose up -d --build ansible

stop-ansible:
	docker compose down ansible


start-demo-vps:
	docker compose up -d --build vps1 vps2 vps3

stop-demo-vps:
	docker compose down vps1 vps2 vps3

start-demo: start-ansible start-demo-vps

stop-demo: stop-ansible stop-demo-vps

check-inventory:
	docker exec ansible ansible-inventory --list
	
ping-all:
	docker exec ansible ansible all -m ping