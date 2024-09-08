import boto3
import json

def list_services_in_region(region_name):
    session = boto3.Session(region_name=region_name)
    available_services = session.get_available_services()
    indexed_services = {str(index + 1): service for index, service in enumerate(available_services)}
    return indexed_services

def scrape_region_servoces(regions):
    all_regions_services = {}
    for region in regions:
        indexed_services = list_services_in_region(region)
        all_regions_services[region] = indexed_services
    return all_regions_services

if __name__ == "__main__":
    regions = ['us-east-1', 'ap-northeast-1#', 'sa-east-1']  # Add or remove regions as needed
    services_by_region = scrape_region_servoces(regions)
    with open('./output/description.json', 'w') as file:
        file.write(json.dumps({"Regions Services": services_by_region}, indent=4))
    